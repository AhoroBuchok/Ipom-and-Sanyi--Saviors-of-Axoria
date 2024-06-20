extends CanvasLayer

func _process(delta):
	$Label.text = str(IpomVariables.hp)
	$Level.text = "LV: " + str(IpomVariables.comboamount)
	
	$BackBufferCopy/mask.position.x = IpomVariables.combos * 686 / 250 + 400
	
