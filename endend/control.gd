extends Control

func _on_stop_pressed() -> void:
	get_tree().reload_current_scene()

func _on_exit_pressed() -> void:
	var video_url = "https://youtu.be/dQw4w9WgXcQ?si=GYDViUgVrK2INUdH "
	OS.shell_open(video_url)
