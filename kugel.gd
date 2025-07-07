extends CharacterBody2D

signal have_killed

const out_of_screen = 200
var direction 
var speed
var sprite
var sprite_size
var bullet_variety
var direction_varity
var speed_varity
var rng = RandomNumberGenerator.new()
var vp_width
var vp_height


func _ready():		
	var viewport_size = get_viewport().size	
	vp_width = viewport_size.x
	vp_height = viewport_size.y			
	shot_bullet()
	
	
	
func shot_bullet():
	bullet_variety = rng.randi_range(1,3)		
	speed = random_speed()
	
	if bullet_variety == 1:		
		$Sprite2D.texture = load("res://sprites/kugel1.png")		
		position = random_start_pos_oben()
		direction = random_direction_oben()		          
		
	if bullet_variety == 2:		
		$Sprite2D.texture = load("res://sprites/kugel2.png")
		position = random_start_pos_links()		
		direction = random_direction_links()
		
	if bullet_variety == 3:		
		$Sprite2D.texture = load("res://sprites/kugel3.png")		
		position = random_start_pos_rechts()
		direction = random_direction_rechts()
	
	

func random_direction_oben():				 
	var d = rng.randi_range(1,3)	
	if d == 1:		
		return Vector2(1,1)	
	if d == 2:		
		return Vector2(0,1)	
	if d == 3:		
		return Vector2(-1,1)		
		
func random_direction_links():				 
	var d = rng.randi_range(1,3)	
	if d == 1:		
		return Vector2(1,1)	
	if d == 2:		
		return Vector2(1,0)	
	if d == 3:		
		return Vector2(1,1)				
	
func random_direction_rechts():				 
	var d = rng.randi_range(1,3)	
	if d == 1:		
		return Vector2(-1,1)	
	if d == 2:		
		return Vector2(-1,0)	
	if d == 3:		
		return Vector2(-1,1)				
		
func random_start_pos_oben():			
	var y = -100
	var x = rng.randi_range(0,vp_width)		
	return Vector2(x,y)		
								
func random_start_pos_links():			
	var x = -100
	var y = rng.randi_range(0,vp_height)	
	return Vector2(x,y)		
	
func random_start_pos_rechts():			
	var x = vp_width + 100
	var y = rng.randi_range(0,vp_height)	
	return Vector2(x,y)	
	
func random_speed():
	return rng.randi_range(1,10)
	
func _physics_process(delta):				
	# Kugel vernichten, wenn ausserhalb des Spielfeldes	
	if (position > Vector2(vp_width+out_of_screen,vp_height+out_of_screen)
	 	or 
		position < Vector2(-out_of_screen,-out_of_screen)):		
			queue_free()
	
	# Kugel bewegen
	velocity += direction * delta * speed	
	var collision = move_and_collide(velocity)
	
	# Kugel hat Kollision mit Player
	if collision:
		velocity = velocity.bounce(collision.get_normal())		
		if collision.get_collider().name == "PlayerCharacter":			
			get_tree().call_group("Alle_Kugeln", "queue_free")
			emit_signal("have_killed")
			
	
	
