extends Area2D

signal was_found

var vp_width
var vp_height
var rng = RandomNumberGenerator.new()

func _ready() -> void:	
	var viewport_size = get_viewport().size	
	vp_width = viewport_size.x
	vp_height = viewport_size.y				
	position = random_position()

func random_position():
	var rand = 10
	var x = rng.randi_range(rand,vp_width-rand)
	var y = rng.randi_range(rand,vp_height-rand)	
	return Vector2(x,y)

func _on_body_entered(body: Node2D) -> void:	
	if body.name == 'PlayerCharacter':		
		emit_signal("was_found")		
		queue_free()
	# Taler , die auf dem baumstamm liegen wieder löschen	
	if body.name == 'Baumstamm':			
		queue_free()
