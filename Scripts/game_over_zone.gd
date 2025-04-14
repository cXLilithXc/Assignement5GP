extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("Something entered:", body.name)
	if body.is_in_group("player"):
		print("Player entered OutZone — Game Over!")
		get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
