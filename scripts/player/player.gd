extends CharacterBody2D

# 이동 속도
var speed = 200
var velocity = Vector2.ZERO

# 입력
var input_vector = Vector2.ZERO

func _ready():
    pass

func _process(delta):
    # 입력 처리
    input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    
    # 속도 계산
    if input_vector != Vector2.ZERO:
        velocity = input_vector.normalized() * speed
    else:
        velocity = Vector2.ZERO
    
    # 이동
    position += velocity * delta
    
    # 캐릭터 회전 (마우스 방향 바라보기)
    look_at(get_global_mouse_position())

func _input(event):
    if event is InputEventMouseButton:
        if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
            # 왼쪽 클릭 - 총 쏘기
            print("Fire!")
