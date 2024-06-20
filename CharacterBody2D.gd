extends CharacterBody2D
class_name IpomVariables
@onready var animations = $AnimatedSprite2D
#controls
@export var up = KEY_UP
@export var down = KEY_DOWN
@export var left = KEY_LEFT
@export var right = KEY_RIGHT
@export var shoot = KEY_Z
static var damage = 1
#gameplay
@export var speed = 300
@export var bullet : PackedScene
@export var bananas : PackedScene
@export var healthp = 150
static var hp
var canshoot = true
var x = 0
var y = 0
@onready var shootsound = $"Shoot Sound"
var pitchrng = RandomNumberGenerator.new()
var rotationrng = RandomNumberGenerator.new()
#combo
static var combos = 0
static var comboamount = 0
#rng
var rng = RandomNumberGenerator.new()
#deadalive
static var alive = true
#bullet types
@export var spread = false
@export var banana = false
@export var canbanana = true
@export var invavail = false
@export var caninv = true
#position
static var pos = Vector2(0, 0)
@export var inv = false
func _ready():
	hp = healthp
	alive = true
func _physics_process(delta):
	if not game.paused:
		hp = healthp
		
		pos = position
		#bullet leveling
		if comboamount == 2:
			spread = true
		if comboamount == 5:
			banana = true
		if comboamount == 7:
			damage = 1.5
		if comboamount == 20:
			invavail = true
		#Life and death
		if healthp < 1:
			healthp = 0
		#gameplay
		if alive:
			if combos > 0:
				combos -= 1 * delta * 4
			if combos > 99.99:
				combos = 0
				comboamount += 1
				var sound = rng.randi_range(1, 2)
				if sound == 1:
					$Combo1.play()
				if sound == 2:
					$Combo2.play()
				healthp += 50
				
			#hp control
			if healthp > 150:
				healthp = 150
			
			clamp(rotation_degrees, -45, 45)
			animations.play("default")
			x = 0
			y = 0
			if Input.is_key_pressed(up):
				y = -1
			if Input.is_key_pressed(down):
				y = 1
			if Input.is_key_pressed(left):
				x = -1
			if Input.is_key_pressed(right):
				x = 1
			velocity.x = x * speed
			velocity.y = y * speed
			move_and_slide()
			if healthp < 1:
				alive = false
				hide()
				
			if caninv and invavail:
				if Input.is_key_pressed(KEY_X):
					invincibility()

func _process(delta):
	if game.paused:
		$"Invincibility timer".paused = true
		$"Cooldown".paused = true
	if not game.paused:
		$"Invincibility timer".paused = false
		$"Cooldown".paused = false
	if not game.paused:
		if alive:
			#shooting mechanics
			if canshoot:
				if Input.is_key_pressed(shoot):
					canshoot = false
					shootsound.play()
					shootsound.pitch_scale = pitchrng.randf_range(0.7, 1)
					var inst = bullet.instantiate()
					get_parent().add_child(inst)
					inst.position = $Marker2D.global_position
					await get_tree().create_timer(0.07).timeout
					canshoot = true
					#spreadtype
					if spread:
						inst = bullet.instantiate()
						get_parent().add_child(inst)
						inst.position = $Marker2D.global_position
						inst.declared = true
						inst.velocity.x = -200
						inst = bullet.instantiate()
						#
						get_parent().add_child(inst)
						inst.position = $Marker2D.global_position
						inst.declared = true
						inst.velocity.x = 200
					#banana
					if banana:
						var bananarng = RandomNumberGenerator.new()
						var coolbanana = bananarng.randi_range(1, 5)
						if coolbanana == 3:
							inst = bananas.instantiate()
							get_parent().add_child(inst)
							inst.position = $Marker2D.global_position
							inst.declared = true
							inst = bullet.instantiate()
					


func _on_ipom_hitbox_area_entered(area):
	if "choi" in area.name:
		if not inv:
			healthp -= 5
			$hit.play()
			modulate = Color(255, 255, 255)
			await get_tree().create_timer(0.05).timeout
			modulate = Color(1, 1, 1, 1)
func invincibility():
	caninv = false
	inv = true
	modulate = Color(1, 1, 1, 0.5)
	$"Invincibility timer".start()
	




func _on_invincibility_timer_timeout():
	inv = false
	modulate = Color(1, 1, 1, 1)
	$Cooldown.start()


func _on_cooldown_timeout():
	caninv = true
