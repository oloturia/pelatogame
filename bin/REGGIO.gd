extends Button


func _ready():
	if Global.level >= 2:
		self.visible = 1
	if Global.level > 2:
		$Selected.visible = 0
		$Complete.visible = 1
		$Label.visible = 0

#func _process(_delta):
#	pass

func _on_REGGIO_pressed():
	get_tree().change_scene("res://Entro_Reggio_Esco_Reggio.tscn")
	


func _on_REGGIO_mouse_entered():
	get_node("../Brief").text = """
	NOME MISSIONE: Entro Reggio Esco Reggio
	LOCATION: Reggio (REG)
	DESCRIZIONE:Capitan Pelato è confuso dal sapere che esistono due città che si chiamano Reggio. Deve correre per scoprire il mistero.
	"""



func _on_REGGIO_mouse_exited():
	get_node("../Brief").text = ""
