extends CharacterBody2D
@export var hp = 1750
@export var bullet = load("res://enemybulletsmall.tscn")
var time = 0
var frequency = 1.0
var amplitude = 35.0
@export var bois : PackedScene
func _physics_process(delta):
	if game.paused:
		$Timer.paused = true
		$Timer2.paused = true
	else:
		$Timer.paused = false
		$Timer2.paused = false
	if not game.paused:
		time += delta
		var offset = sin(time * frequency * PI * 2) * amplitude
		rotation_degrees += 100 * delta
		global_position.x += offset
		

		
		$Icon.global_rotation_degrees = 0
		$Icon3.global_rotation_degrees = 0
		$Icon2.global_rotation_degrees = 0
		$Icon4.global_rotation_degrees = 0
		$Headspinnger.global_rotation_degrees = 0	
		move_and_slide()


func _on_timer_timeout():
	#1
	var inst = bullet.instantiate()
	get_parent().add_child(inst)
	inst.position = $Icon.global_position
	inst.rotation_degrees = 90
	#2
	inst = bullet.instantiate()
	get_parent().add_child(inst)
	inst.position = $Icon2.global_position
	inst.rotation_degrees = 90
	#3
	inst = bullet.instantiate()
	get_parent().add_child(inst)
	inst.position = $Icon3.global_position
	inst.rotation_degrees = 90
	#4
	inst = bullet.instantiate()
	get_parent().add_child(inst)
	inst.position = $Icon4.global_position
	inst.rotation_degrees = 90
	$Timer.start()


func _on_area_2d_area_entered(area):
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


func _on_timer_2_timeout():
	var inst = bois.instantiate()
	get_parent().add_child(inst)
	inst.position = position
	$Timer2.start()
