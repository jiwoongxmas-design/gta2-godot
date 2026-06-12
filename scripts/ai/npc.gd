extends CharacterBody2D

# NPC 속성
var speed = 100
var velocity = Vector2.ZERO
var target_position = Vector2.ZERO
var state = "idle"  # idle, patrol, alert, chase
var detection_range = 300
var attack_range = 50

func _ready():
    target_position = position

func _process(delta):
    match state:
        "idle":
            update_idle()
        "patrol":
            update_patrol(delta)
        "alert":
            update_alert(delta)
        "chase":
            update_chase(delta)

func update_idle():
    velocity = Vector2.ZERO
    position += velocity

func update_patrol(delta):
    # 순찰 로직
    velocity = (target_position - position).normalized() * speed
    position += velocity * delta

func update_alert(delta):
    # 경계 상태
    velocity = Vector2.ZERO
    position += velocity * delta

func update_chase(delta):
    # 추격 상태
    var player = get_node("/root/Main/Player") # 플레이어 경로 수정 필요
    if player:
        velocity = (player.position - position).normalized() * speed
        position += velocity * delta

func take_damage(damage):
    print("NPC took damage: ", damage)
