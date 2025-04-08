extends Area2D

class_name Flag

func _ready():
	# Conecta o sinal programaticamente (alternativa ao editor)
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body is Player:
		queue_free()
		print("COLISÃO OK COM MARIO!")
	else:
		print("colidiuu")	# Aqui você pode ativar UI, transição, etc.
