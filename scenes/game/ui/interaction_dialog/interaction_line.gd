extends Control

class_name InteractionLine

var answer_question: QuestionAnswer

func set_data(qa: QuestionAnswer):
	answer_question = qa
	$RichTextLabel.text = qa.question
