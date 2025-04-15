extends Node2D

@onready var left_limit = $FloorLimitLeft
@onready var right_limit = $FloorLimitRight
@onready var hard_tiles_node = $"../../HardTiles"
@onready var floor_spawner_location = $"../FloorSpawnerYPosition"
var health_potion_scene: PackedScene = preload("res://Scenes/health_potion.tscn")
signal depth_changed(depth_meters: int)
var floor_tile_scene: PackedScene = preload("res://Scenes/hard_tile.tscn")
var max_tile_quantity = 300;
const tile_size = 32
var current_depth: int = 0
var spawn_next_location: float

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_row()
	spawn_row()
	spawn_row()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.y > spawn_next_location:
		spawn_row()

func spawn_row():
	var left_limit_position = left_limit.global_position
	var right_limit_position = right_limit.global_position
	var new_tile_position = left_limit_position
	
	while new_tile_position.x < right_limit_position.x:
		if randf() > 0.80:
			# 20% chance to leave a gap
			if randf() < 0.10:
				# 10% chance to spawn a potion in that gap
				var potion = health_potion_scene.instantiate()
				potion.global_position = new_tile_position
				hard_tiles_node.add_child(potion)
		else:
			# Otherwise spawn a tile
			var tile = floor_tile_scene.instantiate()
			tile.global_position = new_tile_position
			hard_tiles_node.add_child(tile)

		# Move to the next tile position regardless
		new_tile_position.x += tile_size

	spawn_next_location = global_position.y + tile_size
	current_depth += 3
	emit_signal("depth_changed", current_depth)
	
		
