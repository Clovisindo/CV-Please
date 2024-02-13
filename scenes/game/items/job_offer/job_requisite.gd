extends Panel

var requisite_text
var requisite_answer

func _instantiate_signal_job_requisite(jobNode):
	self.connect("mouse_entered",jobNode,"_on_panel_mouse_entered")
	self.connect("mouse_exited",jobNode,"_on_panel_mouse_exited")
	self.connect("gui_input",jobNode,"_on_job_requisite_panel_gui_input",[requisite_answer])
