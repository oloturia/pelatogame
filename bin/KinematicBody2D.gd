extends KinematicBody2D

var velocity = Vector2()
var inversion = false
var jumping = false
var collision_wall = false
var on_the_floor = true
var parkouring = false
var grab = false

var gravity = 2

func _ready():
	pass

func _process(delta):
	if not jumping and not inversion and not collision_wall and on_the_floor:
		if velocity.x > 0:
			$Pelataz.play("Run Right")
		elif velocity.x < 0:
			$Pelataz.play("Run Left")
			
		if velocity.x > 0 and velocity.x < 0.5:
			velocity.x = 0
			$Pelataz.play("Idle Left")
		if velocity.x < 0 and velocity.x > -0.5:
			velocity.x = 0
			$Pelataz.play("Idle Right")

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
			if velocity.x > 0 or $Pelataz.animation == "Idle Left":
				$Pelataz.play("Jump Right")
			elif velocity.x < 0 or $Pelataz.animation == "Idle Right":
				$Pelataz.play("Jump Left")
			velocity.y = -27
			jumping = true
		else:
			if velocity.x > 0:
				velocity.x -= 0.1
			if velocity.x < 0:
				velocity.x += 0.1
		
	
	if inversion and on_the_floor:
		if velocity.x > 0:
			$Pelataz.play("Skid Right")
		else:
			$Pelataz.play("Skid Left")
		if $Pelataz.frame > 15:
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
					$Pelataz.play("Land Right")
				else:
					$Pelataz.play("Land Left")
		if collision.collider.name == "Wall" and not collision_wall:
				if jumping:
					if (($Pelataz.animation == "Jump Left" or $Pelataz.animation == "Jump Right") and $Pelataz.frame >=13) or ($Pelataz.animation == "Style Left" or $Pelataz.animation == "Style Right") :
						parkouring = true
						grab = true
						if velocity.x > 0:
							$Pelataz.play("Parkour Right")
						else:
							$Pelataz.play("Parkour Left")
				elif not parkouring:
					if velocity.x > 5:
						collision_wall = true
						inversion = false
						position.x -= velocity.x*8
						velocity.x = 0
						$Pelataz.play("Ouch Right")
					elif velocity.x < -5:
						collision_wall = true
						inversion = false
						jumping = false
						position.x -= velocity.x*8
						velocity.x = -0
						$Pelataz.play("Ouch Left")
				else:
					position.x -= velocity.x*10

	if not grab: 
		position.y += velocity.y
		position.x += velocity.x
		velocity.y += gravity


func _on_AnimatedSprite_animation_finished():
	if $Pelataz.animation == "Jump Left" and not on_the_floor:
		$Pelataz.play("Style Left")
	elif $Pelataz.animation == "Jump Right" and not on_the_floor:
		$Pelataz.play("Style Right")
	elif $Pelataz.animation == "Ouch Right":
		$Pelataz.play("Idle Right")
		velocity.x = 0
		collision_wall = false
	elif $Pelataz.animation == "Ouch Left":
		$Pelataz.play("Idle Left")
		velocity.x = 0
		collision_wall = false
#	elif $Pelataz.animation == "Jump Left" and on_the_floor:
#		$Pelataz.play("Land Left")
#	elif $Pelataz.animation == "Jump Right" and on_the_floor:
#		$Pelataz.play("Land Right")
	elif $Pelataz.animation == "Land Left":
		jumping = false
		parkouring = false
		$Pelataz.play("Idle Right")
	elif $Pelataz.animation == "Land Right":
		jumping = false
		parkouring = false
		$Pelataz.play("Idle Left")
	elif $Pelataz.animation == "Parkour Left":
		grab = false
		$Pelataz.play("Parkjump Left")
		velocity.x = -velocity.x*1.5
		velocity.y -= 25
	elif $Pelataz.animation == "Parkour Right":
		grab = false
		$Pelataz.play("Parkjump Right")
		velocity.x = -velocity.x*1.5
		velocity.y -=25


