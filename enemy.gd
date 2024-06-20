extends CharacterBody2D
@export var bullet : PackedScene
const speed = 300
var canshoot = true
@export var hp = 10
@export var blood = load("res://blood.tscn")
func _physics_process(delta):
	if game.paused:
		velocity = Vector2(0, 0)
	if not game.paused:
		$Animations.play("default")
		velocity.x = speed * cos(deg_to_rad(rotation_degrees))
		velocity.y = speed * sin(deg_to_rad(rotation_degrees))
		move_and_slide()
var alive = true

func _process(delta):

	if not game.paused:
		if alive:
			if canshoot:
				canshoot = false
				var inst = bullet.instantiate()
				get_parent().add_child(inst)
				inst.position = self.position
				inst.rotation_degrees = 90
				inst = bullet.instantiate()
				get_parent().add_child(inst)
				inst.position = self.position
				inst.rotation_degrees = 180
				inst = bullet.instantiate()
				get_parent().add_child(inst)
				inst.position = self.position
				inst.rotation_degrees = -90
				inst = bullet.instantiate()
				get_parent().add_child(inst)
				inst.position = self.position
				inst.rotation_degrees = 0
				inst = bullet.instantiate()
				get_parent().add_child(inst)
				inst.position = self.position
				inst.rotation_degrees = 45
				inst = bullet.instantiate()
				get_parent().add_child(inst)
				inst.position = self.position
				inst.rotation_degrees = -45
				inst = bullet.instantiate()
				get_parent().add_child(inst)
				inst.position = self.position
				inst.rotation_degrees = 135
				inst = bullet.instantiate()
				get_parent().add_child(inst)
				inst.position = self.position
				inst.rotation_degrees = 225
				await get_tree().create_timer(0.3).timeout
				canshoot = true
			
			if alive:
				if hp < 1:
					alive = false
					$"kill sound".play()
					$boi.queue_free()
					$Animations.hide()
					var particles = blood.instantiate()
					get_parent().add_child(particles)
					particles.position = self.position
					IpomVariables.combos += 20
					await get_tree().create_timer(1).timeout
					self.queue_free()
					
func _on_area_2d_area_entered(area):
	if "finalpoint" in area.name:
		self.queue_free()
	if "ipombullet" in area.name:
		$"hit sound".play()
		hp -= 2 * IpomVariables.damage
		modulate = Color(255, 255, 255)
		await get_tree().create_timer(0.05).timeout
		modulate = Color(1, 1, 1, 1)
	elif "ipombanana" in area.name:
		$"hit sound".play()
		hp -= 5 * IpomVariables.damage
		modulate = Color(255, 255, 255)
		await get_tree().create_timer(0.05).timeout
		modulate = Color(1, 1, 1, 1)
