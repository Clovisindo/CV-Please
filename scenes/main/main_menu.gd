extends Panel

class_name MainMenuManager


func _ready():
	$PanelContainer/StartGameButton.connect("pressed", self, "_on_start_button_ok_pressed")
	$PanelContainer/CloseGameButton.connect("pressed", self, "_on_close_button_ok_pressed")


func _on_start_button_ok_pressed():
	LoadManager.load_scene(self, "res://scenes/main/main.tscn")

func _on_close_button_ok_pressed():
	get_tree().quit()

