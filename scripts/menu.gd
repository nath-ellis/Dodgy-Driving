extends Node2D


@onready var road = $Road
@onready var play_btn = $UI/Play
@onready var endless_btn = $UI/Modes/Endless
@onready var modes = $UI/Modes


func _on_EnemyTimer_timeout() -> void:
	Manager.add_enemy(road)


func _on_play_btn_pressed() -> void:
	modes.show()
	play_btn.hide()


func _on_endless_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Endless.tscn")
