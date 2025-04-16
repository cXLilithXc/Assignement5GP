extends Area2D


func _on_area_entered(area: Area2D) -> void:
	print("Area entered: ", area.name)

	if area.is_in_group("player"):
		print("Health potion touched by player!")
		if area.get_parent().has_method("restore_health"):
			area.get_parent().restore_health()
		queue_free()
