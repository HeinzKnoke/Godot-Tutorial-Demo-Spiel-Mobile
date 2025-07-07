extends Node2D


var game_scene


func _ready() -> void:	
	game_scene = preload("res://game.tscn")
	
	$Start.connect("show_game",on_show_game)	
	$Start.connect("show_help",on_show_help)	
	$Start.connect("exit",on_exit)
	$Help.connect("show_start",on_show_start)
	
	Score.load_data()
	show_node("Start")	


	
func run_game():
	var instance = game_scene.instantiate()
	add_child(instance)	
	$Game.connect("game_over",on_game_over)	
	show_node("")
	
		
	
func show_node(node_name:String): 
	
	if node_name == "Start":			
		$Start.visible = true	
		$Help.visible = false						
	
	if node_name == "Help":
		$Help.visible = true	
		$Start.visible = false		

			

func on_show_game():
	Score.act_score = 0	
	run_game()			

func on_show_start():	
	show_node("Start")		
	
func on_show_help():		
	show_node("Help")	
	

func on_game_over():	
	Score.save_data()		
	show_node("Start")
	remove_child($Game)

func on_exit():	
	Score.save_data()	
	get_tree().quit()
	
	
	
