extends Node2D


onready var road = $Road
onready var play_btn = $UI/Play
onready var endless_btn = $UI/Modes/Endless
onready var modes = $UI/Modes


func _process(_delta) -> void:
	if play_btn.pressed:
		modes.show()
		play_btn.hide()
	
	if endless_btn.pressed:
		get_tree().change_scene("res://scenes/Endless.tscn")


func _on_EnemyTimer_timeout():
	Manager.add_enemy(road)
