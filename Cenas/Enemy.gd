extends Area2D

class_name Enemy

@export var horizontal_speed = 20
@export var vertical_speed = 100
@onready var ray_cast_2d = $RayCast2D as RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= horizontal_speed * delta
	
	if !ray_cast_2d.is_colliding():
		position.y += vertical_speed * delta
