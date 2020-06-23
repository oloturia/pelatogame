extends Button


func _ready():
	if Global.level >= 1:
		self.visible = 1
		$Label.visible = 1
	if Global.level > 2:
		$Selected.visible = 0
		$Complete.visible = 1
	pass

#func _process(_delta):
#	pass

func _on_PESCARA_pressed():
	get_tree().change_scene("res://Dalle_Ande_a_Pescara.scn")
	


func _on_PESCARA_mouse_entered():
	get_node("../Brief").text = """
	NOME MISSIONE: Dalle Ande a Pescara
	LOCATION: Pescara (PE)
	DESCRIZIONE:Capitan Pelato è inseguito da un argentino dai misteriosi occhiali magici, l'unica via: la fuga.
	"""



func _on_PESCARA_mouse_exited():
	get_node("../Brief").text = ""
