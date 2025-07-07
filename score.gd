extends Node

const file_path := "user://saved.dat"

var act_score = 0
var high_score1 = 0
var high_score2 = 0
var high_score3 = 0
var stufe = 1
var is_high_score = false
var accelometer = false



func load_data():
	var file := ConfigFile.new()
	
	var err := file.load(file_path)
	if err != OK:		
		push_error("Ladefehler Scores")
		return		
	
	var value = file.get_value("Stufen","Stufe")	
	if value != null:
		stufe = int(value)	
	
	var value1 = file.get_value("Score","HighScore1")	
	if value1 != null:
		high_score1 = int(value1)
		
	var value2 = file.get_value("Score","HighScore2")	
	if value2 != null:
		high_score2 = int(value2)
		
	var value3 = file.get_value("Score","HighScore3")	
	if value3 != null:
		high_score3 = int(value3)		
	
	var value4 = file.get_value("Settings","Accelometer")	
	if value4 != null:
		if value4 == "true":
			accelometer = true
		else:
			accelometer = false	
		
func save_data():	
	check_for_highscore()
	
	is_high_score = false
	var file := ConfigFile.new()
	
	file.set_value("Stufen","Stufe",str(stufe))
	file.set_value("Score","HighScore1",str(high_score1))
	file.set_value("Score","HighScore2",str(high_score2))
	file.set_value("Score","HighScore3",str(high_score3))
	file.set_value("Settings","Accelometer",str(accelometer))
	
	var err := file.save(file_path)
	if err != OK:		
		push_error("Schreibfehler Scores")
		return
		
func check_for_highscore():	
	is_high_score = false
	
	if stufe == 1:
		if act_score > high_score1:	
			high_score1 = act_score
			is_high_score = true
	
	if stufe == 2:
		if act_score > high_score2:		
			high_score2 = act_score
			is_high_score = true
			
	if stufe == 3:
		if act_score > high_score3:			
			high_score3 = act_score
			is_high_score = true			
		
	
		
func reset():	
	high_score1 = 0
	high_score2 = 0
	high_score3 = 0
	act_score = 0
	var file := ConfigFile.new()
	file.set_value("Score","HighScore1",str(high_score1))	
	file.set_value("Score","HighScore2",str(high_score2))	
	file.set_value("Score","HighScore3",str(high_score3))	
		
	var err := file.save(file_path)
	if err != OK:		
		push_error("Schreibfehler Scores")
		return
	
