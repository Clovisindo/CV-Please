extends Button

class_name EndPaymentResume

signal load_next_day_scene()


func _ready() -> void:
	$".".connect("pressed", self, "_on_button_ok_pressed")


func _on_button_ok_pressed():
	emit_signal("load_next_day_scene")
	print(" Load next day job.")
	LoadManager.load_scene(self,"res://scenes/main/main.tscn")
