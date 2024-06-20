extends CharacterBody3D
@export var clone = load("res://scene.tscn")
var canclone = true
func _physics_process(delta):
	if not game.paused:
		velocity.z = 10
	else:
		velocity.z = 0
	
	move_and_slide()


func _on_area_3d_area_entered(area):
	if canclone:
		canclone = false
		if "collide" in area.name:
			var inst = clone.instantiate()
			get_parent().add_child(inst)
			inst.position.z -=89.7
