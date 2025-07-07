extends Node2D

signal show_start


func _on_button_ok_pressed() -> void:
	emit_signal("show_start")	
