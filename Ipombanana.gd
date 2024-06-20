extends CharacterBody2D
var rng = RandomNumberGenerator.new()
var declared = false
@export var speed = 200
@export var bullet = load("res://Ipombullet.tscn")
func _ready():
	if not declared:
		velocity.x = randf_range(-100, 100)

func _physics_process(delta):
	velocity.x = speed * cos(deg_to_rad(rotation_degrees))
	velocity.y = speed * sin(deg_to_rad(rotation_degrees))
	rotation_degrees +=10
	move_and_slide()

	if game.paused:
		$Timer.paused = true
	if not game.paused:
		$Timer.paused = false



func _on_ipombanana_area_entered(area):
	if "boi" in area.name:
		$AudioStreamPlayer.play()
		self.queue_free()
	elif "finalpoint" in area.name:
		self.queue_free()


func _on_timer_timeout():
	self.queue_free()
