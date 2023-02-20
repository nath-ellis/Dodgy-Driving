extends Node2D


const life_sprite = preload("res://assets/life.png")

onready var player = $Player
onready var road = $Road
onready var lives = $Lives
onready var enemies = [
	$Road/Enemy,
]


func add_lives() -> void:
	var x = 557
	var y = 48
	
	# Add correct amount of lives
	for _i in range(player.get_meta("lives")):
		var life = Sprite.new()
		life.position = Vector2(x, y)
		life.scale = Vector2(2, 2)
		life.set_texture(life_sprite)
		
		lives.add_child(life)
		
		# Overflow to the left if the player has enough lives to reach the bottom
		if y >= get_viewport_rect().size.y - 96:
			x -= 78
			y = 48
		else:
			y += 70


func _ready() -> void:
	add_lives()


func _process(_delta) -> void:
	if player.get_meta("lives") <= 0:
		get_tree().change_scene("res://scenes/GameOver.tscn")


func restart() -> void:
	# Reset enemy positions
	for e in enemies:
		e.call("randomize_enemy")
	
	# Remove leftover lives
	for l in lives.get_children():
		l.queue_free()
	
	add_lives()
