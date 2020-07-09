extends AnimatedSprite

var step = preload("res://sound/step.ogg")
var audio_node = null
var swearing = []

func _ready():
	audio_node = $AudioStreamPlayer
	audio_node.connect("finished",self,"destroy_self")
	audio_node.stop()
	swearing.append(preload("res://sound/cp/acciderba.ogg"))
	swearing.append(preload("res://sound/cp/accipicchia.ogg"))
	swearing.append(preload("res://sound/cp/corbezzoli.ogg"))
	swearing.append(preload("res://sound/cp/corpodibacco.ogg"))
	swearing.append(preload("res://sound/cp/mondoladro.ogg"))
	swearing.append(preload("res://sound/cp/nespole.ogg"))
	swearing.append(preload("res://sound/cp/orcamiseria.ogg"))
	swearing.append(preload("res://sound/cp/orcocane.ogg"))
	swearing.append(preload("res://sound/cp/orcodiavolo.ogg"))
	swearing.append(preload("res://sound/cp/perbaccobacchissimo.ogg"))
	swearing.append(preload("res://sound/cp/perbaccobaccone.ogg"))
	swearing.append(preload("res://sound/cp/perbaccotacco.ogg"))
	swearing.append(preload("res://sound/cp/perdindirindina.ogg"))
	swearing.append(preload("res://sound/cp/pergiove.ogg"))
	swearing.append(preload("res://sound/cp/poffarbacco.ogg"))
	swearing.append(preload("res://sound/cp/sacripante.ogg"))

func _process(_delta):
	if self.animation == "Run Left" or self.animation == "Run Right":
		if self.frame == 8 or self.frame == 18:
			audio_node.stream = step
			audio_node.play()
	
	if self.animation == "Ouch Left" or self.animation == "Ouch Right":
		if self.frame == 12 or self.frame == 16 or self.frame == 21:
			audio_node.stream = step
			audio_node.play()
		if self.frame == 24:
			swearing()


func swearing():
	var swear = randi()%16
	audio_node.stream = swearing[swear]
	audio_node.play()
