extends CharacterBody2D

# 이동 속도
var speed = 200
var current_velocity = Vector2.ZERO

# 입력
var input_vector = Vector2.ZERO

# 무기
var current_weapon = null
var has_weapon = false

func _ready():
	print("Player initialized")

func _physics_process(delta):
	# 입력 처리
	input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 속도 계산
	if input_vector != Vector2.ZERO:
		current_velocity = input_vector.normalized() * speed
	else:
		current_velocity = Vector2.ZERO
	
	# 이동
	position += current_velocity * delta
	
	# 캐릭터 회전 (마우스 방향 바라보기)
	if get_global_mouse_position() != global_position:
		look_at(get_global_mouse_position())

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			# 왼쪽 클릭 - 총 쏘기
			fire()

func fire():
	print("Player fired!")
	if current_weapon:
		current_weapon.fire(global_position, (get_global_mouse_position() - global_position).normalized())
	else:
		print("No weapon equipped!")

func take_damage(damage: int):
	print("Player took damage: ", damage)

func equip_weapon(weapon):
	current_weapon = weapon
	has_weapon = true
	print("Weapon equipped: ", weapon)
