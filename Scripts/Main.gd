extends Node

var leftScore = 0
var rightScore = 0

func _ready():
	$music.volume_db = 0
	$music.play()

func _on_Game_leftLose():
	rightScore += 1
	$HUD.update_score(leftScore, rightScore)


func _on_Game_rightLose():
	leftScore += 1
	$HUD.update_score(leftScore, rightScore)
	

func _on_Game_hit():
	$hit.play()


func _on_Game_lose():
	$music.volume_db = -15
	$lose.play()


func _on_lose_finished():
	$music.volume_db = 0


func _on_music_finished():
	$music.play() # i don't know how to loop it :p
