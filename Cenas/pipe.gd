extends StaticBody2D

class_name Pipe

const TOP_PIPE_HEIGHT = 16

@export var height = 32
@export var is_traversable = false

@onready var collision_shape_2d = $CollisionShape2D
@onready var pipe_body_sprite = $PipeBodySprite

func _ready():
	#ajusta a região do sprite
	var region_rect = Rect2(pipe_body_sprite.region_rect)
	region_rect.size = Vector2(32, height - TOP_PIPE_HEIGHT)
	pipe_body_sprite.region_rect = region_rect
	pipe_body_sprite.position = Vector2(0, height / 2)
	
	#ajusta o tamanho da colisao, porque nem sempre o cano vai ter o mesmo tamanho
	var shape = RectangleShape2D.new()
	shape.size = Vector2(32, height)
	collision_shape_2d.shape = shape
	collision_shape_2d.position = Vector2(0, height /2 - TOP_PIPE_HEIGHT / 2)
