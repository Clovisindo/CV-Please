extends Panel

var requisite_text
var requisite_answer

func _ready():
	var control = get_tree().root.get_child(0)
	self.connect("mouse_entered",control,"_on_Panel_mouse_entered")
	self.connect("mouse_exited",control,"_on_Panel_mouse_exited")
	self.connect("gui_input",control,"_on_Panel_gui_input",[requisite_answer])
