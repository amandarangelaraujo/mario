extends Enemy

class_name Goomba

func die():
	super.die()
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	get_tree().create_timer(0.5).timeout.connect(queue_free)

func _on_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
