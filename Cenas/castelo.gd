extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("MARIO ENTROU NO CASTELO!")
		get_tree().change_scene_to_file("res://Cenas/fim_jogo.tscn")
#get_tree().change_scene_to_file("res://Cenas/fase2.tscn") # <- ajuste o caminho se for diferente
