extends Panel

export(PackedScene) var curriculumNode

var skill_text
var skill_answer

func _instantiate_signal_skill_panel(cvNode):
	self.connect("mouse_entered",cvNode,"_on_panel_mouse_entered")
	self.connect("mouse_exited",cvNode,"_on_panel_mouse_exited")
	self.connect("gui_input",cvNode,"_on_skill_panel_gui_input",[skill_answer])
