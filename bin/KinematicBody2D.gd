extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var inversion = false
var jumping = false
var collision_wall = false
var on_the_floor = true
var parkouring = false
var grab = false

var gravity = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _process(delta):
	if not jumping and not inversion and not collision_wall and on_the_floor:

		if velocity.x > 0:
			$AnimatedSprite.play("Run Right")
		elif velocity.x < 0:
			$AnimatedSprite.play("Run Left")
		
		if velocity.x > 0 and velocity.x < 0.5:
			velocity.x = 0
			$AnimatedSprite.play("Idle Left")
		if velocity.x < 0 and velocity.x > -0.5:
			velocity.x = 0
			$AnimatedSprite.play("Idle Right")

		if Input.is_action_pressed("ui_right"):
			if velocity.x < -5:
				inversion = true
			if velocity.x < 10:
				velocity.x += 0.5
		elif Input.is_action_pressed("ui_left"):
			if velocity.x > 5:
				inversion = true
			if velocity.x > -10:
				velocity.x -= 0.5
		elif Input.is_action_pressed("ui_up"):
			if velocity.x > 0 or $AnimatedSprite.animation == "Idle Left":
				$AnimatedSprite.play("Jump Right")
			elif velocity.x < 0 or $AnimatedSprite.animation == "Idle Right":
				$AnimatedSprite.play("Jump Left")
			velocity.y = -27
			jumping = true
		else:
			if velocity.x > 0:
				velocity.x -= 0.1
			if velocity.x < 0:
				velocity.x += 0.1
		
	
	if inversion and on_the_floor:
		if velocity.x > 0:
			$AnimatedSprite.play("Skid Right")
		else:
			$AnimatedSprite.play("Skid Left")
		if $AnimatedSprite.frame > 15:
			inversion = false
			velocity.x = velocity.x/-2
	
			

	
	
	var collision = move_and_collide(velocity*delta)
	on_the_floor = false
	if collision:
		if collision.collider.name == "Terrain":
			velocity.y = 0
			on_the_floor = true
			if parkouring or jumping:
				if velocity.x > 0:
					$AnimatedSprite.play("Land Right")
				else:
					$AnimatedSprite.play("Land Left")
		if collision.collider.name == "Fill" and not collision_wall:
			if not parkouring:
				if velocity.x > 5:
					collision_wall = true
					inversion = false
					position.x -= velocity.x*8
					velocity.x = 0
					$AnimatedSprite.play("Ouch Right")
				elif velocity.x < -5:
					collision_wall = true
					inversion = false
					jumping = false
					position.x -= velocity.x*8
					velocity.x = -0
					$AnimatedSprite.play("Ouch Left")
				else:
					position.x -= velocity.x*10
				
	if collision_wall:
		if $AnimatedSprite.frame > 40:
			if $AnimatedSprite.animation == "Ouch Right":
				$AnimatedSprite.play("Idle Left")
			else:
				$AnimatedSprite.play("Idle Right")
			velocity.x = 0
			collision_wall = false
			
			
	if not grab: 
		position.y += velocity.y
		position.x += velocity.x
		velocity.y += gravity


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Jump Left" and not on_the_floor:
		$AnimatedSprite.play("Style Left")
	elif $AnimatedSprite.animation == "Jump Right" and not on_the_floor:
		$AnimatedSprite.play("Style Right")
#	elif $AnimatedSprite.animation == "Jump Left" and on_the_floor:
#		$AnimatedSprite.play("Land Left")
#	elif $AnimatedSprite.animation == "Jump Right" and on_the_floor:
#		$AnimatedSprite.play("Land Right")
	elif $AnimatedSprite.animation == "Land Left":
		jumping = false
		parkouring = false
		$AnimatedSprite.play("Idle Right")
	elif $AnimatedSprite.animation == "Land Right":
		jumping = false
		parkouring = false
		$AnimatedSprite.play("Idle Left")
	elif $AnimatedSprite.animation == "Parkour Left":
		grab = false
		$AnimatedSprite.play("Parkjump Left")
		velocity.x = -velocity.x*1.5
		velocity.y -= 25
	elif $AnimatedSprite.animation == "Parkour Right":
		grab = false
		$AnimatedSprite.play("Parkjump Right")
		velocity.x = -velocity.x*1.5
		velocity.y -=25

func _on_FrontBack_body_entered(body):
	if body.name == "Fill" and jumping:
		if (($AnimatedSprite.animation == "Jump Left" or $AnimatedSprite.animation == "Jump Right") and $AnimatedSprite.frame >=13) or ($AnimatedSprite.animation == "Style Left" or $AnimatedSprite.animation == "Style Right") :
			parkouring = true
			grab = true
			if velocity.x > 0:
				$AnimatedSprite.play("Parkour Right")
			else:
				$AnimatedSprite.play("Parkour Left")
		else:
			jumping = false
			velocity.x = 0
			velocity.y = 0


