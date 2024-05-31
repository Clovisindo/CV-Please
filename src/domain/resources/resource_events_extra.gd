extends Resource

class_name EventsExtra

export(Array, Resource) var events_list


func instantiate(_events):
	events_list = _events


func get_event_list():
	return events_list
