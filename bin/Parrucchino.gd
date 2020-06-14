extends KinematicBody2D


func _ready():
	pass 


func _on_Area2D_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	queue_free()
