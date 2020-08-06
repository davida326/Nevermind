extends Control

var value = 0

func set_value(amount):
	value = amount
	$RichTextLabel.bbcode_text = "[right]{coin}[/right]".format({"coin":value})
