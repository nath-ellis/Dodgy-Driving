extends Node2D


var life_sprite = preload("res://assets/life.png")
var x = 557
var y = 38


func _ready():
	# Add correct amount of lives
	for _i in range($Player.get_meta("lives")):
		var life = Sprite.new()
		life.position = Vector2(x, y)
		life.scale = Vector2(2, 2)
		life.set_texture(life_sprite)
		
		$Lives.add_child(life)
		y += 70


func _process(_delta):
	if $Player.get_meta("lives") <= 0:
		pass
		# TODO: Add consequences for dying


func restart():
	# Reset enemy positions
	$Road/Enemy.call("randomize_enemy")
	
	# Remove leftover lives
	for l in $Lives.get_children():
		l.queue_free()
		
	# Add lives
	x = 557
	y = 38
	
	for _i in range($Player.get_meta("lives")):
		var life = Sprite.new()
		life.position = Vector2(x, y)
		life.scale = Vector2(2, 2)
		life.set_texture(life_sprite)
		
		$Lives.add_child(life)
		y += 70
