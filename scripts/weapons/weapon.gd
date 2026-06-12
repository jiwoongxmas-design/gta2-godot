extends Node2D

func _ready():
    pass

func _process(delta):
    pass

func fire(position: Vector2, direction: Vector2):
    print("Weapon fired from ", position, " in direction ", direction)
    # 총알 생성 및 발사 로직
