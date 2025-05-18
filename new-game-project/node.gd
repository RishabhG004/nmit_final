extends Node

var is_door_unlocked = false

func unlock_door():
	is_door_unlocked = true
	$"door'/CollisionShape2D".disabled = true
	$"door'".modulate = Color(0.5, 1, 0.5)
	var anim = $"door'/AnimationPlayer"
	if anim and not anim.is_playing():
		anim.play("open")

func restart_level():
	get_tree().reload_current_scene()
