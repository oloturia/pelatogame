extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.animation == "Run Left" or self.animation == "Run Right":
		if self.frame == 8 or self.frame == 18:
			$step.play()
		else:
			$step.stop()
	else:
		$step.stop()
