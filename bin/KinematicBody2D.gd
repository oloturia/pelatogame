extends KinematicBody2D

var velocity = Vector2()
var inversion = false
var jumping = false
var collision_wall = false
var on_the_floor = false
var parkouring = false
var grab = false
var ducking = false
var collision_fagiano = false
var arrived = false
var panting = false
var gravity = 2
var t = 0
var stamina = 3000

func _ready():
	pass

func _process(delta):
	
	if stamina < 100 and not panting:
		panting = true
		if velocity.x > 0:
			$Pelataz.play("Anf Right")
		else:
			$Pelataz.play("Anf Left")
		velocity.x = 0
			
	if panting:
		velocity.x = 0
		if $Pelataz.frame == 18 and stamina < 1000:
			$Pelataz.frame = 6
			
	if velocity.x == 0 and stamina != 3000:
		stamina += 100
		if stamina > 3000:
			stamina = 3000
	
	if not jumping and not arrived and not inversion and not collision_wall and not collision_fagiano and on_the_floor and not panting:
		if velocity.x > 0:
			stamina -= velocity.x
			if not ducking:
				$Pelataz.play("Run Right")
			else:
				$Pelataz.play("DuckRun Right")
		elif velocity.x < 0:
			stamina += velocity.x
			if not ducking:
				$Pelataz.play("Run Left")
			else:
				$Pelataz.play("DuckRun Left")
				
		if velocity.x > 0 and velocity.x < 0.5:
			velocity.x = 0
			if stamina < 1000:
				panting = true
				$Pelataz.play("Anf Left")
			else:
				$Pelataz.play("Idle Left")

		if velocity.x < 0 and velocity.x > -0.5:
			velocity.x = 0
			if stamina < 1000:
				panting = true
				$Pelataz.play("Anf Right")
			else:
				$Pelataz.play("Idle Right")


		if Input.is_action_pressed("ui_right"):
			if not ducking:
				if velocity.x < -5:
					inversion = true
				#if velocity.x < 10:
				if velocity.x < (stamina/100):
					velocity.x += 0.5
			else:
					velocity.x += 0.1
		elif Input.is_action_pressed("ui_left"):
			if not ducking:
				if velocity.x > 5:
					inversion = true
				#if velocity.x > -10:
				if velocity.x > -(stamina/100):
					velocity.x -= 0.5
			else:
					velocity.x -= 0.1
		elif Input.is_action_pressed("ui_up") and not ducking:
			stamina -= 100
			if velocity.x > 0 or $Pelataz.animation == "Idle Left":
				velocity.x += 1
				$Pelataz.play("Jump Right")
			elif velocity.x < 0 or $Pelataz.animation == "Idle Right":
				velocity.x -= 1
				$Pelataz.play("Jump Left")
			velocity.y = -27
			jumping = true
		elif Input.is_action_pressed("ui_down"):
			if not ducking:
				if velocity.x > 0:
					$Pelataz.play("Ducking Right")
					ducking = true
				elif velocity.x < 0:
					$Pelataz.play("Ducking Left")
					ducking = true
		else:
			ducking = false
			if velocity.x > 0:
				velocity.x -= 0.1
			if velocity.x < 0:
				velocity.x += 0.1
			
	
	if ducking:
		$Head.position.y  = 100
	else:
		$Head.position.y = 0
	
	if collision_fagiano and $Pelataz.frame > 7:
		velocity.x = 0
	
	if inversion and on_the_floor:
		if velocity.x > 0:
			$Pelataz.play("Skid Right")
		else:
			$Pelataz.play("Skid Left")
		if $Pelataz.frame > 15:
			inversion = false
			velocity.x = velocity.x/-2

	on_the_floor = false
	var collision = move_and_collide(velocity*delta,true,true,true)

	if collision:
		if collision.collider.name == "Terrain" and velocity.y > 0:
			on_the_floor = true
			velocity.y = 0
			if parkouring or jumping:
				if velocity.x > 0:
					$Pelataz.play("Land Right")
				else:
					$Pelataz.play("Land Left")
			else:
				if $Pelataz.animation == "Fall Right":
					$Pelataz.play("Stumble Right")
				elif $Pelataz.animation == "Fall Left":
					$Pelataz.play("Stumble Left")

	if not grab: 
		position.y += velocity.y
		position.x += velocity.x
		if not on_the_floor:
			velocity.y += gravity
			if velocity.y > 30:
				if velocity.x > 0:
					$Pelataz.play("Fall Right")
				else:
					$Pelataz.play("Fall Left")

	if position.y > 2000:
			get_tree().reload_current_scene()
			
	if arrived:
		if t == 0:
			t = OS.get_unix_time()
		else:
			if OS.get_unix_time() - t > 5:
				get_tree().change_scene("res://Game_Map.tscn")
		

func resetPelato(LR = ""):
	if LR == "L":
		$Pelataz.play("Idle Left")
	else:
		$Pelataz.play("Idle Right")
	inversion = false
	jumping = false
	collision_wall = false
	on_the_floor = true
	parkouring = false
	grab = false
	ducking = false
	collision_fagiano = false
	panting = false

func _on_AnimatedSprite_animation_finished():
	if $Pelataz.animation == "Anf Left":
			stamina = 3000
			resetPelato("R")
	if $Pelataz.animation == "Anf Right":
			stamina = 3000
			resetPelato("L")
	if $Pelataz.animation == "Jump Left" and not on_the_floor:
		$Pelataz.play("Style Left")
	elif $Pelataz.animation == "Jump Right" and not on_the_floor:
		$Pelataz.play("Style Right")
	elif $Pelataz.animation == "Ouch Right":
		resetPelato("R")
		velocity.x = 0
	elif $Pelataz.animation == "Ouch Left":
		resetPelato("L")
		velocity.x = 0
	elif $Pelataz.animation == "Land Left":
		resetPelato("R")
	elif $Pelataz.animation == "Land Right":
		resetPelato("L")
	elif $Pelataz.animation == "Parkour Left":
		grab = false
		$Pelataz.play("Parkjump Left")
		velocity.x = -velocity.x*1.5
		velocity.y = -25
	elif $Pelataz.animation == "Parkour Right":
		grab = false
		$Pelataz.play("Parkjump Right")
		velocity.x = -velocity.x*1.5
		velocity.y = -25
	elif $Pelataz.animation == "Stumble Left":
		resetPelato("L")
	elif $Pelataz.animation == "Stumble Right":
		resetPelato("R")

func _on_Head_body_entered(_body):
	if jumping:
		if (($Pelataz.animation == "Jump Left" or $Pelataz.animation == "Jump Right") and $Pelataz.frame >=8) or ($Pelataz.animation == "Style Left" or $Pelataz.animation == "Style Right") :
			parkouring = true
			grab = true
			if velocity.x > 0:
				$Pelataz.play("Parkour Right")
			else:
				$Pelataz.play("Parkour Left")
		else:
			jumping = false
	
	if not jumping:
		if velocity.x > 5:
			collision_wall = true
			inversion = false
			position.x -= velocity.x
			velocity.x = 0
			$Pelataz.play("Ouch Right")
		elif velocity.x < -5:
			collision_wall = true
			inversion = false
			jumping = false
			position.x -= velocity.x
			velocity.x = 0
			$Pelataz.play("Ouch Left")
		else:
			if velocity.x > 0:
				position.x -= 20
				velocity.x = -0.5
			else:
				position.x += 20
				velocity.x = 0.5
		if on_the_floor:
			position.y -=10
	

func _on_Feet_body_entered(_body):
		jumping = false
		parkouring = false
		inversion = false
		collision_fagiano = true
		if velocity.x > 0:
			velocity.x = 25
			$Pelataz.play("Stumble Left")
		else:
			velocity.x = -25
			$Pelataz.play("Stumble Right")


func _on_AreaArrivo_arrived():
	var win = preload("res://sound/sha.ogg")
	arrived = true
	velocity.x = 0
	velocity.y = 0
	resetPelato("R")
	$Pelataz/AudioStreamPlayer.stream = win
	$Pelataz/AudioStreamPlayer.play()


