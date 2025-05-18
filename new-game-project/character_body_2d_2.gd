extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite_2d = $Sprite2D
@onready var death_sound = $DeathSound # Optional
@onready var lever_area = $"../levergworl"
@onready var door = $"../door'" # Replace with actual door node name if different

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_dead = false
var near_lever = false
var door_opened = false # Prevent re-opening

func _physics_process(delta):
	if is_dead:
		return

	# Animation
	if velocity.x > 1 or velocity.x < -1:
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"

	# Jumping
	if Input.is_action_just_pressed("player2_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	var direction = Input.get_axis("player2_left", "player2_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	sprite_2d.flip_h = velocity.x < 0

	# Collision check
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name.begins_with("spikegwor") or collision.get_collider().name.begins_with("bomb"):
			die()

func die():
	if is_dead:
		return
	is_dead = true
	print("Player2 died!")
	if death_sound:
		death_sound.play()
	sprite_2d.animation = "dead"
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

func open_door():
	if door_opened:
		return
	door_opened = true

	if door:
		print("Player2 reached the lever. Door opening...")

		# Play lever animation
		var lever_anim = lever_area.get_node("AnimationPlayer")
		if lever_anim and not lever_anim.is_playing():
			lever_anim.play("open")

		# Tell the door to unlock itself
		if door.has_method("unlock"):
			door.unlock()

func _on_levergworl_body_entered(body):
	if body.name == "Player2":
		near_lever = true
		open_door()

func _on_levergworl_body_exited(body):
	if body.name == "Player2":
		near_lever = false
