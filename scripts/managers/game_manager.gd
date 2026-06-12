extends Node

# 게임 상태
var is_game_running = false
var is_paused = false
var current_level = 1
var player_score = 0
var player_money = 0

# 참조
var player = null
var hud = null
var camera = null

func _ready():
	print("=== GTA2 Godot Clone ===")
	print("Engine Version: ", Engine.get_version_info().string)
	print("Game Started!")
	
	# 플레이어 로드
	await get_tree().process_frame
	find_nodes()
	
	is_game_running = true

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()

func find_nodes():
	# 플레이어 찾기
	player = get_tree().get_first_child_in_group("player")
	if not player:
		var root = get_tree().root
		player = root.find_child("Player", true, false)
		if player:
			player.add_to_group("player")
	
	# HUD 찾기
	hud = get_tree().root.find_child("HUD", true, false)
	if hud:
		print("HUD found")
	else:
		print("HUD not found")

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused
	print("Game paused: ", is_paused)

func add_money(amount: int):
	player_money += amount
	print("Money added: $", amount, " Total: $", player_money)
	if hud and hud.has_method("set_player_money"):
		hud.set_player_money(player_money)

func add_score(amount: int):
	player_score += amount
	print("Score added: ", amount)

func restart_level():
	print("Restarting level...")
	get_tree().reload_current_scene()

func next_level():
	current_level += 1
	print("Moving to level: ", current_level)
	# TODO: 다음 레벨 로드

func game_over():
	print("Game Over!")
	is_game_running = false
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

func get_game_info() -> Dictionary:
	return {
		"level": current_level,
		"score": player_score,
		"money": player_money,
		"is_running": is_game_running,
		"is_paused": is_paused
	}
