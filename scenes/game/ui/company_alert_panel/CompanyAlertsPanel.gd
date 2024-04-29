extends Panel


func _ready() -> void:
	$CloseButton.connect("pressed", self, "_hide_panel_alert")


func _show_panel_alert(message):
	$AlertLabel.text = message
	self.visible = true


func _hide_panel_alert():
	self.visible = false
