extends Node2D


onready var play_btn = $UI/Play


func _process(_delta) -> void:
	if play_btn.pressed:
		get_tree().change_scene("res://scenes/Game.tscn")
