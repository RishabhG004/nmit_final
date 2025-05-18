extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite_2d = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Animation
	if velocity.x > 1 or velocity.x < -1:
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"

	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	sprite_2d.flip_h = velocity.x < 0

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name.begins_with("spikegwor") or collision.get_collider().name.begins_with("bomb"):
			get_tree().reload_current_scene()
