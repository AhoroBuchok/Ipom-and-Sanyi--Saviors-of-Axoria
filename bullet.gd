extends CharacterBody2D
var rng = RandomNumberGenerator.new()
var declared = false
func _ready():
	if not declared:
		velocity.x = randf_range(-100, 100)

func _physics_process(delta):
	if game.paused:
		velocity = Vector2(0, 0)
	if not game.paused:
		velocity.y = -850

		move_and_slide()


func _on_ipombullet_area_entered(area):
	if "boi" in area.name:
		self.queue_free()
	if "finalpoint" in area.name:
		self.queue_free()
