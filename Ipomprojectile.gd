extends CharacterBody2D
var rng = RandomNumberGenerator.new()
var declared = false
const speed = 500
@export var locked = false
var target = null
var cantarget = true

func _on_detector_area_entered(area):
	locked = true
	if area == null:
		target = null
		locked = false
	if locked:
		target = area
		

func _physics_process(delta):
	velocity.x = speed * cos(deg_to_rad(rotation_degrees))
	velocity.y = speed * sin(deg_to_rad(rotation_degrees))
	if cantarget:
		if locked and not target == null:
			look_at(target.global_position)
	move_and_slide()


func _on_ipombullet_area_entered(area):
	if "boi" in area.name:
		self.queue_free()
	if "finalpoint" in area.name:
		self.queue_free()





func _on_timer_timeout():
	cantarget = false
	target = false
