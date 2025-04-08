extends CanvasLayer
@onready var coins_label = $CoinsLabel
#func set_score(points: int):
	#score_label.text = "SCORE: %d" % points

func set_coins(coins: int):
	coins_label.text = "COINS: %d" % coins
	
#func on_finish():
	#center_container.visible = true
