extends Button

class_name ButtonInteractionDialog

signal show_chat_log
signal hide_chat_log

var chat_visible = false


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		if !chat_visible:
			emit_signal("show_chat_log")
			chat_visible = true
		else:
			emit_signal("hide_chat_log")
			chat_visible = false
