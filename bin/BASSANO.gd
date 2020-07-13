extends Button


func _ready():
	if Global.level >= 4:
		self.visible = 1
		$Label.visible = 1
	if Global.level > 4:
		$Selected.visible = 0
		$Complete.visible = 1
		$Label.visible = 0
		
#func _process(_delta):
#	pass

func _on_BASSANO_pressed():
	get_tree().change_scene("res://final_fight.tscn")
	


func _on_BASSANO_mouse_entered():
	get_node("../Brief").text = """
	NOME MISSIONE: Finale di Partita
	LOCATION: Bassano del Grappa (VI)
	DESCRIZIONE:Capitan Pelato incontra il suo acerrimo nemico, il FUNGO MALEDETTO!
	basta mi sono proprio rotto i coglioni di fare 'sto gioco devo ricordarmi di togliere questo testo prima di rilasciare la vers. ufficiale che due balle"""



func _on_BASSANO_mouse_exited():
	get_node("../Brief").text = ""
