extends Label

func _ready():
	Global.reset_current_score()  # Explicit reset when game starts
	var spawner = get_parent().get_node("FloorSpawner")
	spawner.connect("depth_changed", Callable(self, "_on_depth_changed"))
	update_display()

func _on_depth_changed(depth_meters: int) -> void:
	Global.current_score = depth_meters
	Global.update_high_score(depth_meters)
	update_display()

func update_display():
	text = "Current: %dm\nBest: %dm" % [
		max(0, Global.current_score - 9),
		max(0, Global.persistent_high_score - 9)
	]
