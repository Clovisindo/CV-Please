extends Panel

const MAX_WIDTH = 600
const MAX_HEIGHT = 600

var rect_size_x = 530
var rect_size_y = 100
var label_rect_size_y = 100

var velocity = -25
var x_limit = -10
var is_hovered = false


func _ready() -> void:
	$CloseButton.connect("pressed", self, "_hide_panel_alert")
	self.rect_min_size.y = rect_size_y


func _show_panel_alert(message):
	$AlertLabel.text = message
	get_node("AlertLabel").rect_size.y = get_node("AlertLabel").get_content_height()
	self.visible = true

	_set_size_by_text()


func _hide_panel_alert():
	self.visible = false
	$ButtonEffectSFX.playing = true


func _set_size_by_text():
	self.rect_size.y = get_node("AlertLabel").rect_size.y + 40


func _on_RequisitePanel_mouse_exited() -> void:
	is_hovered = false


func _on_RequisitePanel_mouse_entered() -> void:
	is_hovered = true
