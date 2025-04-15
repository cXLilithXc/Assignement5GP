extends Node2D


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/boulder_dash.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
