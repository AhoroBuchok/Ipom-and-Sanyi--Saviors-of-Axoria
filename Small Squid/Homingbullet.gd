extends CharacterBody2D
const speed = 350
@export var lock = false
var pro = true
func _physics_process(delta):
	if not game.paused:
		velocity.x = speed * cos(deg_to_rad(rotation_degrees))
		velocity.y = speed * sin(deg_to_rad(rotation_degrees))
		move_and_slide()
		if lock:
			look_at(IpomVariables.pos)



func _on_choi_bulletsmall_area_entered(area):
	if "finalpoint" in area.name:
		self.queue_free()
	if "IpomHitbox" in area.name:
		self.queue_free()


func _on__5_timeout():
	lock = true
	$"1_5".start()


func _on_15_timeout():
	lock = false
