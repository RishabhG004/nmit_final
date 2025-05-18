extends Area2D

func set_collision_enabled(enable: bool) -> void:
	if has_node("CollisionShape2D"):
		$CollisionShape2D.disabled = not enable
	if has_node("Sprite"):
		$Sprite.visible = enable  # Optional
