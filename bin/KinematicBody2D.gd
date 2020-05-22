extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var inversion = false
var jumping = false
var falling = false

var gravity = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _process(delta):
	if not jumping and not inversion and not falling:
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
			velocity.y = -27
			jumping = true
		else:
			if velocity.x > 0:
				velocity.x -= 0.1
			if velocity.x < 0:
				velocity.x += 0.1
		
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
	
	if inversion:
		if velocity.x > 0:
			$AnimatedSprite.play("Skid Right")
		else:
			$AnimatedSprite.play("Skid Left")
		if $AnimatedSprite.frame > 15:
			inversion = false
			velocity.x = velocity.x/-2
	
	if jumping:
		if not ($AnimatedSprite.animation == "Jump Right" or $AnimatedSprite.animation == "Jump Left"):
			if velocity.x > 0 or (velocity.x == 0 and $AnimatedSprite.animation == "Idle Left"):
				$AnimatedSprite.play("Jump Right")
			else:
				$AnimatedSprite.play("Jump Left")

		if $AnimatedSprite.frame > 25:
			if velocity.x == 0:
				if $AnimatedSprite.animation == "Jump Right":
					$AnimatedSprite.play("Idle Left")
				else:
					$AnimatedSprite.play("Idle Right")
			jumping = false

	#if (not jumping) or (jumping and $AnimatedSprite.frame >= 15) :
	velocity.y += gravity
		
	if not falling:
		if velocity.y > 20:
			falling = true
	
	position.y += velocity.y
	position.x += velocity.x
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.collider.name == "TileMap":
			velocity.y = 0
			falling = false
			if jumping:
				$AnimatedSprite.play();
				
	
	if jumping and not collision:
		if $AnimatedSprite.frame == 15:
			$AnimatedSprite.stop()
			falling = true
