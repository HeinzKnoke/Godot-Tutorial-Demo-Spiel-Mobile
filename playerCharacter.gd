extends CharacterBody2D


var vp_width
var vp_height
var speed = 800  # move speed in pixels/sec
var dead = false
var with_accelerometer = true

func _ready():
	with_accelerometer = Score.accelometer

func explode(lives):	
	dead = true
	$AudioKrabbeln.stop()
	$AnimationKrabbeln.visible = false		
	$AnimatedExplosion.visible = true
	$AnimatedExplosion.play()
	#Explosion und tot	
	$AudioExplosion.play()
	await get_tree().create_timer(2).timeout	
	
	
	# wenn aber noch Leben vorhanden sind
	if lives > 0:		
		dead = false		
		# wieder lebendig...		
		$AudioLebendig.play()		
		$AnimatedExplosion.visible = false
		$AnimationKrabbeln.visible = true
		$AnimationKrabbeln.play()		
		$AudioKrabbeln.play()		
	

func _process(delta):
	if dead == false:			
		var direction  = Vector2(0,0)
		
		if with_accelerometer:
			var accel = Input.get_accelerometer()
			direction = Vector2(accel.x,-accel.y)
		else:	
			if Input.is_action_pressed("move_right"):
				direction.x = 1
			if Input.is_action_pressed("move_left"):
				direction.x = -1
			if Input.is_action_pressed("move_down"):
				direction.y = 1
			if Input.is_action_pressed("move_up"):
				direction.y = -1	
		
		
		if direction.length() > 0: 	
			direction = direction.normalized()		
			rotation = direction.angle()
			velocity = direction * speed
			move_and_collide(velocity*delta)	
			
			#verhindern, dass Player das Spielfeld verlässt				
			position.x = clamp(position.x,0,get_viewport().size.x)
			position.y = clamp(position.y,0,get_viewport().size.y)
			
			if not $AnimationKrabbeln.is_playing():	
				$AnimationKrabbeln.play()
			if not $AudioKrabbeln.is_playing():					
				$AudioKrabbeln.play()			
		else:
			$AnimationKrabbeln.stop()
			$AudioKrabbeln.stop()
