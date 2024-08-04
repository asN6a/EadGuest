extends Control

# Array que contem as informações.
#// OBS: Dá pra fazer isso de diversas formas e talvez até mais praticas
@export var question_data : Array[Dictionary] = [
	{
		"title": "TITLE", # TITULO
		"question": "QUESTION", # PERGUNTA
		"answers": ["Paris", "Londres", "Berlim", "Madri"], # RESPOSTAS
		"correct_index": 0  # Índice da resposta correta
	}
]

func _ready() -> void:
#	Quando der play na cena, vai carregar as informações que o dev adicionou na Array
	EducarQuest_controller()
	
func EducarQuest_controller():
	var list = $VBoxContainer/ResponseButtons # Referencia da lista
	
	for question_index in range(question_data.size()):
		# Abaixo vai armazenar as informações da Array em variaveis
		var data = question_data[question_index]
		var title = data["title"]
		var question = data["question"]
		var answers = data["answers"]
		var correct_index = data["correct_index"]
		
		$VBoxContainer/Core/NAME.text = title
		$VBoxContainer/Core/QUEST.text = question
		
		# Adiciona os botões para as respostas
		for answer_index in range(answers.size()):
			var button = Button.new()
			button.text = answers[answer_index]
			button.name = "button_" + str(answer_index)  # Nome dos botões para identificação
			
#			Cria a conexão do botão para identificar qual resposta é a certa
			button.connect("pressed", Callable(self, "_on_answer_pressed_custom").bind(question_index, answer_index, correct_index))
			
			list.add_child(button) # Adiciona o botão

# O "connect" do button.
func _on_answer_pressed_custom(question_index: int, answer_index: int, correct_index: int) -> void:
	if answer_index == correct_index:
		print("Resposta correta!")
		hide()
	else:
		print("Resposta incorreta!")
