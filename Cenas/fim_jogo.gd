extends CanvasGroup
@onready var label = $Mensagem
@onready var botao = $Button
signal reinicia
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match SceneData.current_level:
		"fase1":
			label.text = "Parabéns, você passou para a Fase 2!"
			botao.text = "Ir para a Fase 2"
		"fase2":
			label.text = "Fim de jogo! Deseja reiniciar?"
			botao.text = "Reiniciar jogo"
		_:
			label.text = "Fase desconhecida!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	emit_signal("reinicia")
	if SceneData.current_level == "fase2":
		$Mensagem.text = str("PARABENS! JOGUE NOVAMENTE")
		get_tree().change_scene_to_file("res://Cenas/main.tscn")
	else:
		get_tree().change_scene_to_file("res://Cenas/fase2.tscn")
