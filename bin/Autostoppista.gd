extends KinematicBody2D


var nobattuta = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$balloon.visible = 0
	$body.play("still")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if nobattuta == 1:
		$body.play("still")
	if nobattuta == 2:
		$body.play("talking")
		$battuta.bbcode_text = "[center]Casalecchio di Reno\nè conosciuta in architettura\ncome [i]dream town[/i][/center]"
	if nobattuta == 3:
		$body.play("still")
	if nobattuta == 4:
		$body.play("talking")
		$battuta.bbcode_text = "[center]Molti degli edifici hanno\npropaggini prive di senso apparente\ncome sbalzi indecorosi\nche fulgono nel vuoto.[/center]"
	if nobattuta == 5:
		$body.play("still")
	if nobattuta == 6:
		$body.play("talking")
		$battuta.bbcode_text = "[center]Il motivo di tale audacità\nnon è il mero esistere utile\nma è agire sulla psiche di chi abita.\nCasalecchio è un esempio di [i]psicoarchitettura[/i].[/center]"
	if nobattuta == 7:
		$body.play("still")
	if nobattuta > 9:
		$balloon.visible = 0
		$battuta.visible = 0

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	$Timer.start(0)
	$body.play("talking")
	$balloon.frame = 0
	$balloon.visible = 1
	$balloon.play("default")


func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	$Timer.stop()
	$body.play("still")
	$balloon.visible = 0
	$battuta.visible = 0
	nobattuta = 0


func _on_Timer_timeout():
	nobattuta += 1


func _on_balloon_animation_finished():
	$battuta.visible = 1
	$battuta.bbcode_text = "[center]Ciao Capitan\nPelato![/center]"