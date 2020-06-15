extends KinematicBody2D

var gotcha = false

func _ready():
	pass 


func _on_Area2D_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	$Stars.emitting = true
	$AnimatedSprite.visible = false
	gotcha = true


func _process(_delta):
	if gotcha and not $Stars.emitting:
		queue_free()
