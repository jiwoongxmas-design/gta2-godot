extends Node2D

# 게임 매니저
var player
var camera
var hud

func _ready():
    print("=== GTA2 Godot Clone ===")
    print("Game Started!")
    
    # 플레이어 로드
    player = get_node("Player")
    camera = player.get_node("Camera2D")
    hud = get_node("HUD")
    
    print("Player loaded: ", player)
    print("Ready to play!")

func _process(delta):
    pass
