extends Node

@export var mob_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	spawn_mob()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start() # Replace with function body.

func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var screen_size = get_viewport().get_visible_rect().size
	var spawn_margin = 100
	var from_position = Vector2()
	
	var side = randi() % 4
	match side:
		0: from_position = Vector2(randf() * screen_size.x, -spawn_margin)               # сверху
		1: from_position = Vector2(screen_size.x + spawn_margin, randf() * screen_size.y) # справа
		2: from_position = Vector2(randf() * screen_size.x, screen_size.y + spawn_margin) # снизу
		3: from_position = Vector2(-spawn_margin, randf() * screen_size.y)                # слева
	var center_position = screen_size / 2
	mob.start(from_position, center_position)
	
	add_child(mob)
