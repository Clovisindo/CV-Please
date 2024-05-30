extends Button

class_name ApplicantCrossMode

signal enable_cross_mode
signal disable_cross_mode

enum CrossModeStatus {
	ENABLE,
	DISABLE,
}

export(CrossModeStatus) var current_status

var is_hovered = false
var event_fired = false


func enable_cross_mode():
	if current_status == CrossModeStatus.DISABLE:
		current_status = CrossModeStatus.ENABLE
		print("Cross mode activado.")


func disable_cross_mode():
	if current_status == CrossModeStatus.ENABLE:
		current_status = CrossModeStatus.DISABLE
		print("Cross mode desactivado.")


func _on_ApplicantCrossMode_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		event_fired = true
		if current_status == CrossModeStatus.ENABLE:
			_process_as_enable(event)
		if current_status == CrossModeStatus.DISABLE:
			_process_as_disable(event)


# func _gui_input(event: InputEvent) -> void:
# 	if current_status == CrossModeStatus.ENABLE:
# 		_process_as_enable(event)
# 	if current_status == CrossModeStatus.DISABLE:
# 		_process_as_disable(event)


func _process_as_enable(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		emit_signal("disable_cross_mode")


func _process_as_disable(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(BUTTON_LEFT):
		emit_signal("enable_cross_mode")


func on_enable_button_cross_mode():
	self.visible = true
	self.disabled = false


func on_disable_button_cross_mode():
	self.visible = false
	self.disabled = true


func _on_ApplicantCrossMode_mouse_exited() -> void:
	is_hovered = false
	event_fired = false


func _on_ApplicantCrossMode_mouse_entered() -> void:
	is_hovered = true
