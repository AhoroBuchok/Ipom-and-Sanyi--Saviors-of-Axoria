extends Node3D

@export var clonetime : PackedScene

func _process(delta):
	position.z +=0.005
	if position.z == 0:
	
