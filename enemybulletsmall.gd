extends CharacterBody2D
const speed = 550

func _physics_process(delta):
	if not game.paused:
		velocity.x = speed * cos(deg_to_rad(rotation_degrees))
		velocity.y = speed * sin(deg_to_rad(rotation_degrees))
		move_and_slide()


func _on_choi_bulletsmall_area_entered(area):
	if "finalpoint" in area.name:
		self.queue_free()
	if "IpomHitbox" in area.name:
		self.queue_free()
	if "ipombanana" in area.name:
		self.queue_free()
