extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var accele_x = 0
var increment_x = 0.01

var accele_y = 0
var increment_y = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x += accele_x
	accele_x = accele_x + increment_x
	if accele_x >= 3 :
		increment_x = -0.01
	if accele_x <= -3:
		increment_x = 0.01
	self.position.y += accele_y
	accele_y = accele_y + increment_y
	if accele_y >= 0.5:
		increment_y = -0.01
	if accele_y <= -0.5:
		increment_y = 0.01
