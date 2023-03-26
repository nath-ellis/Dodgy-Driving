extends Node2D


@onready var road = $Road
@onready var play_btn = $UI/PlayAgain


func _on_EnemyTimer_timeout() -> void:
	Manager.add_enemy(road)


func _on_play_again_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Endless.tscn")


func _on_menu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
