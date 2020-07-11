extends AnimatedSprite

var variation = 0
var step = preload("res://sound/step.ogg")
var skid = preload("res://sound/skid.ogg")
var jump = preload("res://sound/jump.ogg")
var sha = preload("res://sound/sha.ogg")
var rad = preload("res://sound/rad.ogg")
var thud = preload("res://sound/thud.ogg")
var ooph = preload("res://sound/ooph.ogg")
var aanf = preload("res://sound/aanf.ogg")
var audio_node = null
var swearing = []
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	audio_node = $AudioStreamPlayer
	#audio_node.connect("finished",self,"destroy")
	audio_node.stop()
	audio_node.set_pitch_scale(1.5)
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
			
	if self.animation == "Anf Left" or self.animation == "Anf Right":
		if self.frame == 6:
			audio_node.stream = aanf
			audio_node.play()
	
	if self.animation == "Ouch Left" or self.animation == "Ouch Right":
		if self.frame == 0:
			audio_node.stream = thud
			audio_node.play()
		if self.frame == 12 or self.frame == 16 or self.frame == 21:
			audio_node.stream = step
			audio_node.play()
		if self.frame == 24:
			swearing()
	
	if self.animation == "Stumble Left" or self.animation == "Stumble Right":
		if self.frame == 8:
			audio_node.stream = ooph
			audio_node.play()
		if self.frame == 17:
			swearing()
	
	if self.animation == "Parkour Left" or self.animation == "Parkour Right":
		if self.frame == 3:
			audio_node.stream = sha
			audio_node.play()
	
	if self.animation == "Jump Left" or self.animation == "Jump Right":
		if self.frame == 1:
			audio_node.stream = jump
			audio_node.play()
	
	if self.animation == "Land Left" or self.animation == "Land Right":
		if self.frame == 1:
			audio_node.stream = rad
			audio_node.play()
	
	if self.animation == "Skid Left" or self.animation == "Skid Right":
		if self.frame == 1:
			audio_node.stream = skid
			audio_node.play()
		if self.frame == 9:
			audio_node.stream = rad
			audio_node.play()

func swearing():
	var swear = rng.randi_range(0,15)
	audio_node.stream = swearing[swear]
	audio_node.play()
