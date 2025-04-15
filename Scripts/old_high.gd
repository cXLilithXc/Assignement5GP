extends Label

func _ready():
	text = "Womp Womp\nScore: %dm\nBest: %dm" % [
		max(0, Global.current_score - 9),
		max(0, Global.persistent_high_score - 9)
	]
