extends MarginContainer


class_name DialogBox


onready var label = $MarginContainer/Label
onready var timer = $LetterDisplayTimer

const MAX_WIDTH = 256

var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal finished_displaying()


func display_text(text_to_display:String):
    text = text_to_display
    label.text = text_to_display

    # yield(self,"finished")
    rect_min_size.x = min(rect_size.x, MAX_WIDTH)

    if rect_size.x > MAX_WIDTH:
        label.autowrap  = true
        # yield(self,"finished")
        # yield(self,"finished")
        rect_min_size.x = rect_scale.y
    
    # rect_global_position.x = rect_scale.x /2
    # rect_global_position.y = rect_scale.y  + 24

    label.text = ""
    _display_letter()


func _display_letter():
    label.text += text[letter_index]

    letter_index += 1
    if letter_index >= text.length():
        emit_signal("finished_displaying")# signal para gameManager cuando se acabe de escribir el texto
        letter_index = 0
        return
    
    match text[letter_index]:
        "!",".",",","?":
            timer.start(punctuation_time)
        " ":
            timer.start(space_time)
        _:
            timer.start(letter_time)



func _on_LetterDisplayTimer_timeout() -> void:
	_display_letter()

func _show_current_message(message):
    display_text(message)
