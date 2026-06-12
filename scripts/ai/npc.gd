extends CharacterBody2D

# NPC 속성
var speed = 100
var current_velocity = Vector2.ZERO
var target_position = Vector2.ZERO
var state = "idle"  # idle, patrol, alert, chase
var detection_range = 300
var attack_range = 50
var health = 100
var max_health = 100

var player = null
var patrol_points = []
var current_patrol_index = 0

func _ready():
	target_position = position
	# 게임 매니저에서 플레이어 찾기
	await get_tree().process_frame  # 한 프레임 대기
	find_player()

func _physics_process(delta):
	match state:
		"idle":
			update_idle()
		"patrol":
			update_patrol(delta)
		"alert":
			update_alert(delta)
		"chase":
			update_chase(delta)

func find_player():
	# 씬 트리에서 플레이어 찾기
	player = get_tree().get_first_child_in_group("player")
	if not player:
		player = get_parent().get_node_or_null("Player")

func update_idle():
	current_velocity = Vector2.ZERO
	position += current_velocity

func update_patrol(delta):
	# 순찰 로직
	if player and is_player_in_range():
		set_state("chase")
		return
	
	current_velocity = (target_position - position).normalized() * speed
	position += current_velocity * delta

func update_alert(delta):
	# 경계 상태
	if player and is_player_in_range():
		set_state("chase")
	else:
		set_state("patrol")

func update_chase(delta):
	# 추격 상태
	if player:
		var distance = position.distance_to(player.position)
		
		if distance > detection_range:
			set_state("patrol")
			return
		
		if distance < attack_range:
			# 공격 범위
			attack_player()
		else:
			# 플레이어 쫓기
			current_velocity = (player.position - position).normalized() * speed
			position += current_velocity * delta
			look_at(player.position)

func is_player_in_range() -> bool:
	if not player:
		return false
	return position.distance_to(player.position) < detection_range

func attack_player():
	if player:
		player.take_damage(10)
		print("NPC attacked player!")

func set_state(new_state: String):
	state = new_state
	print("NPC state changed to: ", new_state)

func take_damage(damage: int):
	health -= damage
	print("NPC took damage: ", damage, " Health: ", health)
	
	if health <= 0:
		die()

func die():
	print("NPC died!")
	queue_free()
