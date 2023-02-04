extends Node2D


var play_btn


func _ready():
	play_btn = $UI/Play


func _process(_delta):
	if play_btn.pressed:
		get_tree().change_scene("res://scenes/Game.tscn")
