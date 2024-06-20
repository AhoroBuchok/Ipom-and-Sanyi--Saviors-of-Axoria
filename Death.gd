extends Node2D
@export var line : PackedScene
var time = 0
var frequency = 1.0
var amplitude = 35.0

func _process(delta):
	pass


func _on_timer_timeout():
	var inst = line.instantiate()
	get_parent().add_child(inst)
	inst.position = $Marker2D.position


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()


func _on_button_pressed():
	game.paused = false
	game.boss = false
	IpomVariables.comboamount = 0
	IpomVariables.combos = 0
	get_tree().change_scene_to_file("res://Mainframe.tscn")
	
