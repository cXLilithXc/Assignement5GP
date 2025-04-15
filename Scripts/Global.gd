extends Node

# Scores
var current_score := 0
var persistent_high_score := 0

func _ready():
	load_high_score()
	reset_current_score()  # Ensure fresh start

func reset_current_score():
	current_score = 0

func update_high_score(new_score: int):
	if new_score > persistent_high_score:
		persistent_high_score = new_score
		save_high_score()

func save_high_score():
	var file = FileAccess.open("user://highscore.save", FileAccess.WRITE)
	file.store_var(persistent_high_score)
	file.close()

func load_high_score():
	if FileAccess.file_exists("user://highscore.save"):
		var file = FileAccess.open("user://highscore.save", FileAccess.READ)
		persistent_high_score = file.get_var()
		file.close()
