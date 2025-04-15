extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D
var health := 1
var is_invincible := false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_facing_right = true
signal health_changed(value)
signal game_over
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(delta):
	animate()
	flip()
	if health <= 0:
		emit_signal("game_over")
		print("Game Over!")
		get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
		return
func animate():
	if not is_on_floor():
		animatedSprite.play("jump")	
	elif abs(velocity.x) > 0.05:
		animatedSprite.play("run")
	else:
		animatedSprite.play("idle")
	
func flip():
	if velocity.x < -0.5 and is_facing_right:
		scale.x *= -1
		is_facing_right = false
	if velocity.x > 0.5 and not is_facing_right:
		scale.x *= -1
		is_facing_right = true	

func _on_damage_body_entered(body: Node2D) -> void:
	print("rock Hit")
	take_damage()





func take_damage():
	if is_invincible:
		return

	health -= 1
	is_invincible = true
	print("Player took damage! Health: ", health)
	emit_signal("health_changed", health)
	blink()
	await get_tree().create_timer(3.0).timeout
	is_invincible = false



func blink():
	for i in range(10):  
		animatedSprite.visible = false
		await get_tree().create_timer(0.1).timeout
		animatedSprite.visible = true
		await get_tree().create_timer(0.1).timeout
