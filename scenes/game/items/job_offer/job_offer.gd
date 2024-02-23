extends Control

class_name JobOffer

export(PackedScene) var requisite_scene

onready var state_machine = $StateMachine


func _ready():
	var job_offer_container = get_node("JobOfferPanel/VBoxContainer")
	_instance_new_requisite_line("requisite 1","answer 1",job_offer_container)
	_instance_new_requisite_line("requisite 2","answer 2",job_offer_container)
	_instance_new_requisite_line("requisite 3","answer 3",job_offer_container)


func _instance_new_requisite_line(requisite_name, requisite_answer, container):
	var requisite_panel = requisite_scene.instance()
	requisite_panel.initialize(self, requisite_name, requisite_answer)
	container.add_child(requisite_panel)


func _gui_input(event):
	state_machine.current_state.handle_input(event)


func requisite_checked(requisite):
	print(requisite)
