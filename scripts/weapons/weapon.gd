extends Node2D

# 무기 속성
var weapon_name = "Pistol"
var damage = 25
var fire_rate = 0.1  # 초 단위
var max_ammo = 120
var current_ammo = 120
var last_fire_time = 0.0

var muzzle_flash_scene = preload("res://scenes/weapons/muzzle_flash.tscn")

func _ready():
	print("Weapon initialized: ", weapon_name)
	current_ammo = max_ammo

func _process(delta):
	pass

func fire(position: Vector2, direction: Vector2):
	var current_time = Time.get_ticks_msec() / 1000.0
	
	if current_time - last_fire_time < fire_rate:
		return
	
	if current_ammo <= 0:
		print("Out of ammo!")
		return
	
	last_fire_time = current_time
	current_ammo -= 1
	
	print("Weapon fired! Ammo: ", current_ammo, "/", max_ammo)
	
	# 총알 생성 및 발사
	spawn_bullet(position, direction)
	
	# 머즐 플래시
	show_muzzle_flash(position, direction)

func spawn_bullet(position: Vector2, direction: Vector2):
	# 총알 프리팹이 있으면 인스턴스화
	# var bullet = preload("res://scenes/weapons/bullet.tscn").instantiate()
	# bullet.position = position
	# bullet.direction = direction
	# get_parent().add_child(bullet)
	print("Bullet spawned at: ", position, " Direction: ", direction)

func show_muzzle_flash(position: Vector2, direction: Vector2):
	# 머즐 플래시 이펙트
	print("Muzzle flash at: ", position)

func reload():
	current_ammo = max_ammo
	print(weapon_name, " reloaded!")

func has_ammo() -> bool:
	return current_ammo > 0

func get_ammo_percentage() -> float:
	if max_ammo == 0:
		return 0.0
	return float(current_ammo) / float(max_ammo)
