extends CanvasLayer

func _process(delta):
	if game.paused:
		show()
	else:
		hide()
