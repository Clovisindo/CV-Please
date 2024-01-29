extends Control

var MouseOver = false
var eventFired = false

func _init():
	print("Init")

func _on_Panel_gui_input(event):
	if event is InputEventMouseButton:
		if MouseOver == true && eventFired == false:
			print("Answer 1")
			eventFired = true

func _on_Panel_mouse_entered():
	MouseOver = true

func _on_Panel_mouse_exited():
	MouseOver = false
	eventFired = false
