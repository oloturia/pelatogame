extends Node2D

var accele_x = 0
var increment_x = 0.01

var accele_y = 0
var increment_y = 0.01

func _ready():
	pass 
	
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
