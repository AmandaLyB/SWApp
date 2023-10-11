extends CharacterBody2D
# TODO: Add death animation and incorporate video elements at 01:05.

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var player
var chase = false
var doDamage = false
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Ensure game starts with Idle anim
func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	# Detect and attack player
	if chase == true:
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			print("move left")
			animated_sprite.flip_h = true
		else:
			print("move right")
			animated_sprite.flip_h = false
		velocity.x = direction.x * SPEED
	if chase == false:
		velocity.x = 0
		
	move_and_slide()
		

func _on_player_detection_area_body_entered(body):
	if body.name == "Player":
		print("Player Detected!")
		chase = true
			
		


func _on_player_detection_area_body_exited(body):
	if body.name == "Player":
		print("Player Escaped!")
		chase = false
		animated_sprite.play("Idle")

func _on_player_damage_area_body_entered(body):
	if body.name == "Player":
		doDamage = true
		while (doDamage):
			await get_tree().create_timer(0.2).timeout
			body.health -= 3


func _on_player_damage_area_body_exited(body):
	if body.name == "Player":
		doDamage = false
