extends Block

class_name Mystery_box


enum BonusType {
	COIN,
	SHROOM,
	FLOWER,
	KOOPA
}

#parte dos bonus
const KOOPA_SCENE = preload("res://Cenas/koopa.tscn")
const COIN_SCENE = preload("res://Cenas/coin.tscn")
const SHROOM_SCENE = preload("res://Cenas/shroom.tscn")
const SHOOTING_FLOWER_SCENE = preload("res://shooting_flower.tscn")
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var bonus_type: BonusType = BonusType.COIN
@export var invisible: bool = false

var is_empty = false

func _ready():
	animated_sprite_2d.visible = !invisible
	
func bump(player_mode: Player.PlayerMode):
	if is_empty:
		return
		
	if invisible:
		animated_sprite_2d.visible = true
		invisible = !invisible
	
	super.bump(player_mode)
	make_empty()
	
	match  bonus_type:
		BonusType.COIN:
			spawn_coin()
		BonusType.SHROOM:
			spawn_shroom()
		BonusType.FLOWER:
			spawn_flower()
		BonusType.FLOWER:
			spawn_koopa()

func make_empty():
	is_empty = true
	animated_sprite_2d.play("empty")
	
func spawn_coin():
	var coin = COIN_SCENE.instantiate()
	coin.global_position = global_position + Vector2(0, -16)
	get_tree().root.add_child(coin)
	get_tree().get_first_node_in_group("level_manager").on_coin_collected()
	
func spawn_shroom():
	var shroom = SHROOM_SCENE.instantiate()
	shroom.global_position = global_position
	get_tree().root.add_child(shroom)
	
func spawn_flower():
	var flower = SHOOTING_FLOWER_SCENE.instantiate()
	flower.global_position = global_position
	get_tree().root.add_child(flower)
	
func spawn_koopa():
	var KOOPA = KOOPA_SCENE.instantiate()
	KOOPA.global_position = global_position
	get_tree().root.add_child(KOOPA)
