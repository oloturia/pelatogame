extends Button


func _ready():
	pass

#func _process(_delta):
#	pass

func _on_FANO_pressed():
	get_tree().change_scene("res://Road_To_Fano.scn")
	


func _on_FANO_mouse_entered():
	get_node("../Brief").text = """
	NOME MISSIONE: Road to Fano
	LOCATION: Comune di FANO (PU)
	DESCRIZIONE:Capitan Pelato deve raggiungere Fano prima che faccia buio, riuscirà nell'impresa?
	"""



func _on_FANO_mouse_exited():
	get_node("../Brief").text = ""
