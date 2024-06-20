extends Node

func _on_node_2d_die():
	get_tree().change_scene_to_file("res://Death.tscn")
