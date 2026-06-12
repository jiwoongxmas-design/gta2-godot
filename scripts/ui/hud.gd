extends CanvasLayer

func _ready():
    pass

func _process(delta):
    # HUD 업데이트
    pass

func update_health(health: int, max_health: int):
    print("Health: ", health, "/", max_health)

func update_ammo(ammo: int):
    print("Ammo: ", ammo)

func update_money(money: int):
    print("Money: $", money)
