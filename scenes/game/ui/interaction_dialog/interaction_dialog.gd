extends Control

class_name InteractionDialog

export(PackedScene) onready var interaction_line_scene


func add_interaction_line(qa: QuestionAnswer):
	var new_line = interaction_line_scene.instance()
	new_line.set_data(qa)
	$VScrollBar/VBoxContainer.add_child(new_line)
