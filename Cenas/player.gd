extends CharacterBody2D

class_name Player

enum PlayerMode {small, big, shooting}
@onready var animacao: AnimatedSprite2D = $Animacao
@onready var body_colisao: CollisionShape2D = $BodyColisao
@onready var area_colisao: CollisionShape2D = $Area2D/AreaColisao

@export_group("locomotion")
@export var run_speed_damping = 0.5
@export var speed = 150
@export var jump_velocity = -350

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	if Input.is_action_just_released("jump") and velocity.y<0:
		velocity.y *=0.5
		
	var direction = Input.get_axis("left", "right") 
	
	if direction:
		velocity.x = lerp(velocity.x, speed * direction, run_speed_damping * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed *  delta)
	
	move_and_slide()
