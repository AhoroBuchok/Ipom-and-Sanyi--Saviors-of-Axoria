extends CharacterBody2D


func _process(delta):
	velocity.x = 200
	velocity.y = 200
	move_and_slide()


func _on_area_2d_area_entered(area):
	if "die" in area.name:
		queue_free()
