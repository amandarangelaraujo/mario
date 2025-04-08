extends Node

class_name LevelManager

var points = 0
var coins = 0

@export var ui: UI
@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		print("player null")
	if player != null:
		player.points_scored.connect(on_points_scored)
	else:
		push_warning("player não foi encontrado")
	
func on_points_scored(points_scored: int):
	points += points_scored
	ui.set_score(points)

func on_coin_collected():
	print("coin collected")
	$"../AudioPonto".play()
	coins += 1
	ui.set_coins(coins)
