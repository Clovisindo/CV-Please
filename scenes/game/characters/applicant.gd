extends Panel

export (Texture) var portrait 
var appl_name

func _ready():
	_set_applicant_data(portrait,"applicant 1")

func _set_applicant_data( texture, name):
	$Portrait.texture = texture
	$Name.set_bbcode("[center]%s[/center]" % name)
