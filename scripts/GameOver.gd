extends Node2D


onready var road = $Road
onready var play_btn = $UI/PlayAgain


func _process(_delta) -> void:
	if play_btn.pressed:
		get_tree().change_scene("res://scenes/Endless.tscn")


func _on_EnemyTimer_timeout():
	Manager.add_enemy(road)
