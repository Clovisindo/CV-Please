extends Control

class_name InteractionDialog

export(PackedScene) onready var interaction_line_scene


func add_interaction_line(text: String):
	var new_line = interaction_line_scene.instance()
	new_line.add_text(text)
	$VScrollBar/VBoxContainer.add_child(new_line)
