extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: Node) -> void:
	if body.name == "Player2":
		print("Player2 activated the lever!")

		var door = get_parent().get_node("Door")  # assuming Door is sibling
		if door and door.has_method("set_collision_enabled"):
			door.set_collision_enabled(false)
