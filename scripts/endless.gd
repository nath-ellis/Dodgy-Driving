extends Node2D


const LIFE_SPRITE = preload("res://assets/life.png")

var rand = RandomNumberGenerator.new()

onready var player = $Player
onready var road = $Road
onready var lives = $Lives


func add_lives() -> void:
	var x = 557
	var y = 48
	
	# Add correct amount of lives
	for _i in range(player.get_meta("lives")):
		var life = Sprite.new()
		life.position = Vector2(x, y)
		life.scale = Vector2(2, 2)
		life.set_texture(LIFE_SPRITE)
		
		lives.add_child(life)
		
		# Overflow to the left if the player has enough lives to reach the bottom
		if y >= get_viewport_rect().size.y - 96:
			x -= 78
			y = 48
		else:
			y += 70


func _ready() -> void:
	rand.randomize()
	add_lives()


func _process(_delta) -> void:
	if player.get_meta("lives") <= 0:
		get_tree().change_scene("res://scenes/GameOver.tscn")
		
	if rand.randi_range(1, 100) == 5 and !Manager.lane_blocked:
		Manager.block_lane(road)
	
	if Time.get_unix_time_from_system() - Manager.started_blocking >= 10 and Manager.lane_blocked:
		Manager.open_lane()


func restart() -> void:
	Manager.remove_all_enemies(road)

	# Remove leftover lives
	for l in lives.get_children():
		l.queue_free()
	
	add_lives()
	Manager.open_lane()


# Add enemy
func _on_EnemyTimer_timeout():
	Manager.add_enemy(road)
