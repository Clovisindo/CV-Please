extends Panel

var requisite_text
var requisite_answer

func _instantiate_connect(jobNode):
	self.connect("mouse_entered",jobNode,"_on_Panel_mouse_entered")
	self.connect("mouse_exited",jobNode,"_on_Panel_mouse_exited")
	self.connect("gui_input",jobNode,"_on_Panel_gui_input",[requisite_answer])
