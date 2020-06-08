extends KinematicBody2D


func _ready():
	pass 


func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	queue_free()
