extends GPUParticles2D

func _process(delta):
	await get_tree().create_timer(0.1).timeout
	emitting = false
	await get_tree().create_timer(1).timeout
	self.queue_free()
