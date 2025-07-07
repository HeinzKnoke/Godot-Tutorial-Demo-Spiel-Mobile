extends Control

func _ready() -> void:	
	if Score.accelometer:
		visible = false
	else:	
		visible = true
		position.x =   get_viewport().size.x -500
		position.y =   get_viewport().size.y - 300
