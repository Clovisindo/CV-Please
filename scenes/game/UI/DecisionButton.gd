extends Button

export (EnumUtils.applicantSolution) var result  = EnumUtils.applicantSolution.valid

func _instantiate_connect(gameManagerNode):
	self.connect("mouse_entered",gameManagerNode,"_on_Panel_mouse_entered")
	self.connect("mouse_exited",gameManagerNode,"_on_Panel_mouse_exited")
	self.connect("gui_input",gameManagerNode,"_on_Panel_gui_input",[result])
