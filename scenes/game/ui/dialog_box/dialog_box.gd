extends MarginContainer


class_name DialogBox


onready var label = $MarginContainer/Label
onready var label_name:Label = $CharacterNameLabel
onready var timer = $LetterDisplayTimer
onready var timer_release = $ReleaseTimer

const MAX_WIDTH = 256

var text = ""
var letter_index = 0
var typeDialogBox
var skill

var player_name = "Clovis"
var applicant_name = ""
var next_message = ""


var rect_size_x = 80
var rect_size_y = 55

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

var processing = false

signal finished_displaying


func initialize(text_to_display) -> void:
    self.visible = true
    rect_size.x = rect_size_x
    rect_size.y = rect_size_y
    label.autowrap = false
    text = text_to_display
    label.text = text_to_display


func display_text(text_to_display:String):
    initialize(text_to_display)

    rect_min_size.x = min(rect_size.x, MAX_WIDTH)

    if rect_size.x > MAX_WIDTH:
        label.autowrap  = true
        rect_min_size.x = rect_scale.y
    
    label.text = ""
    _display_letter()


func _display_letter():
    label.text += text[letter_index]

    letter_index += 1
    if letter_index >= text.length():
        if typeDialogBox == EnumUtils.TypeDialogBox.PLAYER:
            typeDialogBox = EnumUtils.TypeDialogBox.APPLICANT
        else:
            typeDialogBox = EnumUtils.TypeDialogBox.PLAYER
        emit_signal("finished_displaying",applicant_name, next_message, typeDialogBox, skill)
        processing = false
        timer_release.start()
        # signal para gameManager cuando se acabe de escribir el texto
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

func _show_current_message(_applicant_name, current_message, _next_message, _typeDialogBox, _skill):
    if !processing:
        skill = _skill
        processing = true
        timer_release.stop()
        typeDialogBox = _typeDialogBox
        if typeDialogBox == EnumUtils.TypeDialogBox.PLAYER:
            label_name.text = player_name
            label_name.add_color_override("font_color", Color( 0, 0, 1, 1 ))
            applicant_name = _applicant_name
        else:
            label_name.add_color_override("font_color", Color( 0, 1, 0, 1 ))
            label_name.text = _applicant_name
        applicant_name = _applicant_name
        next_message = _next_message
        display_text(current_message)


func _on_ReleaseTimer_timeout() -> void:
	self.visible = false
