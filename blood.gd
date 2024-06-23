extends GPUParticles2D

func _on_timer_2_timeout():
	emitting = false
	$Timer.start()

func _on_timer_timeout():
	self.queue_free()
