extends CharacterBody2D

class_name Player


signal points_scored(points: int)

enum PlayerMode {small, big, shooting}
@onready var animacao: AnimatedSprite2D = $Animacao
@onready var body_colisao: CollisionShape2D = $BodyColisao
@onready var area_colisao: CollisionShape2D = $Area2D/AreaColisao
@onready var animated_sprite_2d = $Animacao as PlayerAnimatedSprite

@export_group("locomotion")
@export var run_speed_damping = 0.5
@export var speed = 150
@export var jump_velocity = -350

@export_group("Stomping Enemies")
@export var min_stomp_degree = 35
@export var max_stomp_degree = 145
@export var stomp_y_velocity = -150

var player_mode = PlayerMode.small
const POINTS_LABEL_SCENE = preload("res://Cenas/points_label.tscn")
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
	
	animated_sprite_2d.trigger_animation(velocity, direction, player_mode)
	
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area is Enemy:
		handle_enemy_collision(area)

func handle_enemy_collision(enemy: Enemy):
	if enemy == null:
		return
		
	if is_instance_of(enemy, Koopa) and (enemy as Koopa).in_a_shell:
		(enemy as Koopa).on_stomp(global_position)
		spawn_points_label(enemy)
	else:
		var angle_of_collision = rad_to_deg(position.angle_to_point(enemy.position))
		if angle_of_collision > min_stomp_degree && max_stomp_degree > angle_of_collision:
				enemy.die()
				on_enemy_stomped()
				spawn_points_label(enemy)
func spawn_points_label(enemy):
	var points_label = POINTS_LABEL_SCENE.instantiate()
	points_label.position = enemy.position + Vector2(-20, -20)	
	get_tree().root.add_child(points_label)	
	points_scored.emit(100)		
func on_enemy_stomped():
	velocity.y = stomp_y_velocity
