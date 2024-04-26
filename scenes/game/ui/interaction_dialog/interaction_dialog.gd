extends Control

class_name InteractionDialog

export(PackedScene) onready var interaction_line_scene

var current_question_answer: QuestionAnswer
var current_line: InteractionLine
var item_reference

signal reference_used(item)


func _ready():
	$VBoxContainer/Button.connect("pressed", self, "_on_button_pressed")


func add_interaction_line(qa: QuestionAnswer, reference):
	item_reference = reference
	if current_line:
		current_line.disable_text()
		current_question_answer = null
		current_line = null
	current_question_answer = qa
	current_line = interaction_line_scene.instance()
	current_line.enable_text(qa.question)
	$VScrollBar/VBoxContainer.add_child(current_line)


func _on_button_pressed():
	if current_question_answer and current_line:
		current_line.disable_text()
		current_line = interaction_line_scene.instance()
		current_line.enable_text("> %s" % current_question_answer.answer)
		$VScrollBar/VBoxContainer.add_child(current_line)
		current_question_answer = null
		emit_signal("reference_used", item_reference)
