extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const gravity = 1000
var health = 100
var damage = 1
var isDead = false
var isAttacking = false
var lastDirection = 1

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape : CollisionShape2D = $CollisionShape2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	# Handle Jump.
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("Jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction == -1:
		lastDirection = direction
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		lastDirection = direction
		get_node("AnimatedSprite2D").flip_h = false
		
	if direction and isAttacking == false:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animated_sprite.play("Run")
	elif isAttacking == false:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animated_sprite.play("Idle")
			
	
	move_and_slide()
	
	if health < 0:
		print("Player died!")
		queue_free()
		get_tree().change_scene_to_file("res://Scenes/MainScenes/GameOver.tscn")

func _on_attack_1_pressed():
	isAttacking = true
	if lastDirection == 1:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true
	animated_sprite.play("Attack1")
	$LightsaberSound.play()
	await animated_sprite.animation_finished
	isAttacking = false
