extends Panel

class_name EndGameManager

const LEVELS_DIR = "res://scenes/main/endgame_events/"

var end_game_text


func _ready():
	$NewGameButton.connect("pressed", self, "_on_start_button_ok_pressed")
	end_game_text = load_resource_end_game()
	if Global.true_ending:
		$PanelContainer/EndGameRichTextLavel.text = String(end_game_text.true_ending_text)
	else:
		$PanelContainer/EndGameRichTextLavel.text = String(end_game_text.bad_ending_text)


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
