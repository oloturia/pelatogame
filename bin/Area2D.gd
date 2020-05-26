extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision_floor = move_and_collide(delta)
	if collision_floor:
		if collision_floor.collider.name == "Terrain":
			velocity.y = 0
			print("cippirimerlo")
