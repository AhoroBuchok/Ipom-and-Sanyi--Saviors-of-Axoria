extends Node2D


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Mainframe.tscn")


func _on_button_2_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
