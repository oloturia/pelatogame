extends Button


func _ready():
	if Global.level >= 3:
		self.visible = 1
		$Label.visible = 1
	if Global.level > 4:
		$Selected.visible = 0
		$Complete.visible = 1
	pass

#func _process(_delta):
#	pass

func _on_CASALECCHIO_pressed():
	get_tree().change_scene("res://Notti di fuoco a Casalecchio di Reno.tscn")
	


func _on_CASALECCHIO_mouse_entered():
	get_node("../Brief").text = """
	NOME MISSIONE: Notti di fuoco a Casalecchio di Reno
	LOCATION: Casalecchio di Reno (BO)
	DESCRIZIONE:Capitan Pelato deve salvare un cane.
	"""



func _on_CASALECCHIO_mouse_exited():
		get_node("../Brief").text = ""
