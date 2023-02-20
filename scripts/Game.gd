extends Node2D


var life_sprite = preload("res://assets/life.png")


func add_lives():
	var x = 557
	var y = 48
	
	# Add correct amount of lives
	for _i in range($Player.get_meta("lives")):
		var life = Sprite.new()
		life.position = Vector2(x, y)
		life.scale = Vector2(2, 2)
		life.set_texture(life_sprite)
		
		$Lives.add_child(life)
		
		# Overflow to the left if the player has enough lives to reach the bottom
		if y >= get_viewport_rect().size.y - 96:
			x -= 78
			y = 48
		else:
			y += 70


func _ready():
	add_lives()


func _process(_delta):
	if $Player.get_meta("lives") <= 0:
		get_tree().change_scene("res://scenes/GameOver.tscn")


func restart():
	# Reset enemy positions
	$Road/Enemy.call("randomize_enemy")
	
	# Remove leftover lives
	for l in $Lives.get_children():
		l.queue_free()
	
	add_lives()
