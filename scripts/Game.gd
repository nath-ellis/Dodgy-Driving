extends Node2D


func restart():
	# Reset enemy positions
	$Road/Enemy.call("randomize_enemy")
