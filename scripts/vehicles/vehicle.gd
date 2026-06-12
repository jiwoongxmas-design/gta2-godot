extends CharacterBody2D

# 차량 속성
var speed = 300
var max_speed = 400
var acceleration = 500
var friction = 300
var rotation_speed = 5
var current_velocity = Vector2.ZERO
var is_player_inside = false
var player_inside = null

# 엔진 사운드
var engine_sound = null

func _ready():
	print("Vehicle initialized")

func _physics_process(delta):
	if is_player_inside and player_inside:
		handle_input(delta)
	else:
		apply_friction(delta)
	
	position += current_velocity * delta

func handle_input(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_vector != Vector2.ZERO:
		# 회전
		if input_vector.x != 0:
			rotation += input_vector.x * rotation_speed * delta
		
		# 전진/후진
		if input_vector.y != 0:
			var direction = Vector2.RIGHT.rotated(rotation)
			current_velocity = direction * input_vector.y * speed
		else:
			apply_friction(delta)
	else:
		apply_friction(delta)

func apply_friction(delta):
	if current_velocity.length() > 0:
		current_velocity = current_velocity.move_toward(Vector2.ZERO, friction * delta)

func on_player_enter(player):
	is_player_inside = true
	player_inside = player
	print("플레이어가 차량에 탑승했습니다!")

func on_player_exit():
	is_player_inside = false
	player_inside = null
	current_velocity = Vector2.ZERO
	print("플레이어가 차량에서 내렸습니다!")

func take_damage(damage: int):
	print("Vehicle took damage: ", damage)

func get_velocity() -> Vector2:
	return current_velocity
