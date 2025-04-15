extends Node2D

var game_scene = preload("res://Scenes/boulder_dash.tscn")

func _ready():
	# Load and display the saved high score
	Global.load_high_score()
	$CanvasLayer/VBoxContainer/HighScoreLabel.text = "Your HighScore: %dm" % max(0, Global.persistent_high_score - 9)

func _on_start_game_button_pressed():
	get_tree().change_scene_to_packed(game_scene)

func _on_exit_game_button_pressed():
	get_tree().quit()
