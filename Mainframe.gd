extends Node2D
class_name game
var createNormie = true
var createSmall = false
#enemies
@export var Enemy : PackedScene
@export var ECD1 = 1
@export var ECD2 = 2
@export var PCD1 = 5
@export var PCD2 = 8
@export var Small : PackedScene
var rng = RandomNumberGenerator.new()
@export var stage = 1
@export var changestage = true
var stage3ready = true
static var paused = false
static var boss = false
signal die
@export var canspawnspinner = true
@export var spinner : PackedScene
func _process(delta):
	stages()
	
	if Input.is_action_just_pressed("ui_cancel"):
		if paused:
			paused = false
		else:
			paused = true
	if paused:
		$Timer.paused = true
	else:
		if not boss:
			$Timer.paused = false
	if not paused:
		$Label.text = "Stage " + str(stage)
		if not boss:
			if createNormie:
				createNormie = false
				var inst = Enemy.instantiate()
				add_child(inst)
				inst.rotation_degrees = rng.randf_range(45, 135)
				inst.position.x = rng.randf_range(340, 740)
				await get_tree().create_timer(rng.randf_range(ECD1, ECD2)).timeout
				createNormie = true
			if createSmall:
				createSmall = false
				var inst = Small.instantiate()
				add_child(inst)
				inst.position.x = rng.randf_range(340, 740)
				inst.position.y = -54
				inst.velocity.y = 400
				await get_tree().create_timer(rng.randf_range(PCD1, PCD2)).timeout
				createSmall = true
			if boss:
				$Timer.paused = true
				
				
				
				
		if not IpomVariables.alive:
			$AnimationPlayer.play("fade out")
			await get_tree().create_timer(1.5).timeout
			emit_signal("die")



				
		if stage == 3:
			if stage3ready:
				stage3ready = false
				createSmall = true
		if stage == 4:
			ECD1 = 0.5
			ECD2 = 1
		if stage == 6:
			ECD1 = 0.1
			ECD2 = 0.5
			PCD1 = 1
			PCD2 = 2
		if stage == 7:
			ECD1 = 1
			ECD2 = 1.5
			PCD1 = 1
			PCD2 = 2
		if stage == 10:
			if canspawnspinner:
				spawnspinner()
				canspawnspinner = false
				boss = true
func stages():
	pass
	


func _on_music_1_finished():
	$Music1.play()


func _on_timer_timeout():
		stage += 1
		$AnimationPlayer.play("Stage show")
		$Timer.start()
func spawnspinner():
	var inst = spinner.instantiate()
	add_child(inst)
	inst.position = Vector2(269, 85)
	
