extends CharacterBody2D
var rng = RandomNumberGenerator.new()
var declared = false
const speed = 500


func _physics_process(delta):
	velocity.x = speed * cos(deg_to_rad(rotation_degrees))
	velocity.y = speed * sin(deg_to_rad(rotation_degrees))
	move_and_slide()


func _on_ipombullet_area_entered(area):
	if "boi" in area.name:
		self.queue_free()
	if "finalpoint" in area.name:
		self.queue_free()







