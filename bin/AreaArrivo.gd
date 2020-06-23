extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal arrived

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AreaArrivo_area_entered(area):
	Global.level +=1
	if area.name == "Getter":
		emit_signal("arrived")
