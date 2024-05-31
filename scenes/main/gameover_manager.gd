extends Panel

class_name GameOverManager

const LEVELS_DIR = "res://scenes/main/gameover_events/"

var game_over_text


func _ready():
	$GameOverButton.connect("pressed", self, "_on_start_button_ok_pressed")
	game_over_text = load_resource_end_game()
	$PanelContainer/GameOverRichTextLabel.text = String(game_over_text.gameover_text)


func load_resource_end_game():
	var dir = Directory.new()
	if dir.open(LEVELS_DIR) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var regex = RegEx.new()
		regex.compile(".*\\.tres")
		while file_name != "":
			if regex.search(file_name):
				if not dir.current_is_dir():
					var event = ResourceLoader.load(LEVELS_DIR + file_name)
					return event
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func _on_start_button_ok_pressed():
	LoadManager.load_scene(self, "res://scenes/main/main_menu.tscn")
