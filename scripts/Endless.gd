extends Node2D


const life_sprite = preload("res://assets/life.png")
const enemy = preload("res://scenes/Enemy.tscn")

var lane_blocked = false
var lane_to_block = 1
var fixed_enemies = []
var rand = RandomNumberGenerator.new()

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


func block_lane() -> void:
	var x
	
	match lane_to_block:
		1: x = 120
		2: x = 239
		3: x = 361
		4: x = 480
	
	# Add enemies which will stay in the same lane
	for _i in range(8):
		var e = enemy.instance()
		
		e.position = Vector2(x, e.position.y)
		e.set_meta("stay_in_lane", true)
		
		enemies.append(e)
		fixed_enemies.append(e)
		
		road.add_child(e)
		
	lane_blocked = true


func open_lane() -> void:
	for f in fixed_enemies:
		f.set_meta("stay_in_lane", false)
	
	enemies.resize(len(enemies) - len(fixed_enemies))
	fixed_enemies = []
	lane_blocked = false


func _ready() -> void:
	rand.randomize()
	add_lives()


func _process(_delta) -> void:
	if player.get_meta("lives") <= 0:
		get_tree().change_scene("res://scenes/GameOver.tscn")
		
	if rand.randi_range(1, 100) == 5 and !lane_blocked:
		lane_to_block = rand.randi_range(1, 4)
		block_lane()
	
	if rand.randi_range(1, 100) == 6 and lane_blocked:
		open_lane()


func restart() -> void:
	# Reset enemy positions
	for e in enemies:
		e.call("randomize_enemy")
	
	# Remove leftover lives
	for l in lives.get_children():
		l.queue_free()
	
	add_lives()
	open_lane()
