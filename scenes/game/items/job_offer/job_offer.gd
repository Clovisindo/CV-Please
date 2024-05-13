extends Control

class_name JobOffer

signal job_requisite_selected(job_requisite)
signal job_condition_selected(job_condition)

export(PackedScene) onready var requisite_scene
export(PackedScene) onready var condition_scene

var job_requisite_class = load("res://scenes/game/items/job_offer/job_requisite.gd")
var job_condition_class = load("res://scenes/game/items/job_offer/job_special_condition.gd")


func add_requisites(requisites: Array):
	if requisites:
		for requisite in requisites:
			var requisite_panel = requisite_scene.instance()
			requisite_panel.job_offer = self
			requisite_panel.add_data(requisite.textUI, requisite.question, requisite.answer)
			$JobOfferPanel/VBoxContainer.add_child(requisite_panel)


func add_condition(condition):
	if condition:
		var condition_panel = condition_scene.instance()
		condition_panel.job_offer = self
		condition_panel.add_data(
			condition.special_condition,
			condition.condition_name,
			condition.question_player,
			condition.response_applicant
		)
		$JobOfferPanel/VBoxContainer.add_child(condition_panel)


func wired_events(target_manager):
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite is job_requisite_class:
			requisite.connect("send_cross_question", target_manager, "execute_cross_question")


func idle_other_requisites(selected_requisite):
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite is job_requisite_class || requisite is job_condition_class:
			if requisite != selected_requisite:
				requisite.requisite_idle()


func idle_requisites():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite is job_requisite_class || requisite is job_condition_class:
			requisite.requisite_idle()


func disable_requisites():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite is job_requisite_class || requisite is job_condition_class:
			requisite.requisite_disable()


func enable_requisites():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite is job_requisite_class || requisite is job_condition_class:
			requisite.requisite_enable()


func previous_state_skills():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite is job_requisite_class:
			requisite.requisite_as_previous_state()


func enable_cross_requisites():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite is job_requisite_class:
			requisite.requisite_cross_idle()


func disable_other_cross_requisites(selected_requisite):
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite is job_requisite_class:
			if requisite != selected_requisite:
				requisite.requisite_disable()


func disable_cross_requisites():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite is job_requisite_class:
			requisite.requisite_idle()


func save_previous_state():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite is job_requisite_class:
			requisite.save_previous_state()


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func get_cross_requisite():
	for requisite in $JobOfferPanel/VBoxContainer.get_children():
		if requisite is job_requisite_class:
			if requisite.check_is_status_cross_progress(requisite.current_status):
				disable_other_cross_requisites(requisite)
				return requisite


func requisite_checked(requisite):
	emit_signal("job_requisite_selected", requisite)


func condition_checked(condition):
	emit_signal("job_condition_selected", condition)
