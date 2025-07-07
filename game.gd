extends Node2D

signal game_over

var leben = 1

var kugel_inst
var kugel
var kugeln_max

var stern_inst
var stern
var stern_count = 0
var stern_max = 50
var sterne_found = 0

var taler_inst
var taler
var taler_count = 0
var taler_max = 1000
var taler_found = 0

var lb_taler
var lb_sterne
var lb_leben
var audio_taler
var audio_stern


func _ready() -> void:			
	kugel_inst = preload("res://kugeln.tscn")	
	stern_inst = preload("res://sterne.tscn")	
	taler_inst = preload("res://taler.tscn")	
	$SternTimer.wait_time = 3
	$TalerTimer.wait_time = 1	
	anzeige_taler(taler_found)
	anzeige_sterne(sterne_found)
	anzeige_leben(leben)
	anzeige_stufe(Score.stufe)
	set_schwierigkeitsgrad()
	$GameOver.visible = false

func set_schwierigkeitsgrad():
	if Score.stufe == 1:
		$KugelTimer.wait_time = 0.7	
	if Score.stufe == 2:
		$KugelTimer.wait_time = 0.5	
	if Score.stufe == 3:
		$KugelTimer.wait_time = 0.3
	
		
		
	
func anzeige_taler(t):
	$HUD/LabelTaler.text = str(t) + " Taler"
	
func anzeige_sterne(s):	
	$HUD/LabelSterne.text = str(s)	+ " Sterne" 
	
func anzeige_leben(l):	
	$HUD/LabelLeben.text = str(l) + " Leben"		
	
func anzeige_stufe(stufe):	
	$HUD/LabelStufe.text = str(stufe) + " Stufe"			
	
func new_kugel():
	var instance = kugel_inst.instantiate()
	add_child(instance)
	kugel = instance.get_node("Kugel")
	kugel.connect("have_killed",_on_have_killed)	

func new_stern():
	var instance = stern_inst.instantiate()
	add_child(instance)
	stern = instance.get_node("Stern")	
	stern.connect("was_found",_on_star_was_found)	
	
func new_taler():
	var instance = taler_inst.instantiate()
	add_child(instance)
	taler = instance.get_node("Taler")
	taler.connect("was_found",_on_taler_found)	

	

func _on_have_killed():		
	leben -= 1
	$Player/PlayerCharacter.explode(leben)
	$KugelTimer.stop()		
	anzeige_leben(leben)
	if leben == 0:				
		$GameOver.visible = true					
		Score.act_score = taler_found			
		await get_tree().create_timer(4).timeout				
		emit_signal("game_over")		
		
	else:			
		$KugelTimer.start()

func _on_star_was_found():	
	$AudioStern.play()
	sterne_found += 1	
	# wenn 5 Sterne gefunden = 1 Leben zusätzlich
	if sterne_found == 5:
		leben += 1
		sterne_found = 0	
	anzeige_sterne(sterne_found)
	anzeige_leben(leben)
	
	
func _on_taler_found():		
	$AudioTaler.play()	
	taler_found += 1	
	anzeige_taler(taler_found)
	
	

func _on_timer_timeout() -> void:
	new_kugel()
	


func _on_stern_timer_timeout() -> void:
	stern_count += 1
	if stern_count <= stern_max:		
		new_stern()
	

func _on_taler_timer_timeout() -> void:
	taler_count += 1
	if taler_count <= taler_max:
		new_taler()

# Spiel durch Wischen nach unten beenden
func _unhandled_input(event):
	var drag_start_position: Vector2	
	if event is InputEventScreenDrag :
		if event.is_pressed():
			drag_start_position = event.position
		elif event.is_released():
			var swipe_distance = event.position - drag_start_position
			if swipe_distance.length() > 50:
				if swipe_distance.y > 0:	
					emit_signal("game_over")							
						
