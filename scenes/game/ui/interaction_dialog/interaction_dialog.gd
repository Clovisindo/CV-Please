extends Control

class_name InteractionDialog

signal reference_used(item)

export(PackedScene) onready var interaction_line_scene

var current_question_answer: QuestionAnswer
var current_line: InteractionLine
var item_reference


func _show_window_chat():
	get_parent().visible = true


func _hide_window_chat():
	get_parent().visible = false


func add_interaction_line(qa: QuestionAnswer, reference):
	item_reference = reference
	if current_line:
		current_question_answer = null
		current_line = null
	current_question_answer = qa
	current_line = interaction_line_scene.instance()
	current_line.set_player_text(qa.question)
	$VScrollBar/VBoxContainer.add_child(current_line)
	if current_question_answer and current_line:
		current_line = interaction_line_scene.instance()
		current_line.set_applicant_text("> %s" % current_question_answer.answer)
		$VScrollBar/VBoxContainer.add_child(current_line)
		current_question_answer = null
		emit_signal("reference_used", item_reference)
