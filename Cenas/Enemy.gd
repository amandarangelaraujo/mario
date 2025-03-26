extends Area2D

class_name Enemy

@export var horizontal_speed = 20
@export var vertical_speed = 100
@onready var ray_cast_2d = $RayCast2D as RayCast2D
@onready var animated_sprite_2d = $AnimatedSprite as AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= horizontal_speed * delta
	
	if !ray_cast_2d.is_colliding():
		position.y += vertical_speed * delta

func die():
	horizontal_speed = 0
	vertical_speed = 0
	animated_sprite_2d.play("dead")
	
func die_from_hit():
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	
	rotation_degrees = 100
	horizontal_speed = 0
	vertical_speed = 0
	
	var die_tween = get_tree().create_tween()
	die_tween.tween_property(self, "position", position + Vector2(0, -25), .2)
	die_tween.chain().tween_property(self, "position", position + Vector2(0, 500), 4)
func _on_area_entered(area):
	if area is Koopa and (area as Koopa).in_a_sheel and (area as Koopa).horizontal_speed != 0:
		die_from_hit()
	
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
