extends Node2D

# 차량 속성
var speed = 300
var velocity = Vector2.ZERO
var rotation_speed = 5
var is_player_inside = false

func _ready():
    pass

func _process(delta):
    if is_player_inside:
        handle_input(delta)
    
    position += velocity * delta

func handle_input(delta):
    var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    
    if input_vector != Vector2.ZERO:
        # 회전
        if input_vector.x != 0:
            rotation += input_vector.x * rotation_speed * delta
        
        # 전진/후진
        if input_vector.y != 0:
            velocity = Vector2.RIGHT.rotated(rotation) * input_vector.y * speed
        else:
            velocity = Vector2.ZERO
    else:
        velocity = Vector2.ZERO

func on_player_enter():
    is_player_inside = true
    print("플레이어가 차량에 탔습니다!")

func on_player_exit():
    is_player_inside = false
    velocity = Vector2.ZERO
    print("플레이어가 차량에서 내렸습니다!")
