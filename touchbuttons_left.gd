extends Control

func _ready() -> void:	
	if Score.accelometer:
		visible = false
	else:	
		visible = true
		position.x =   60
		position.y =   get_viewport().size.y - 500
