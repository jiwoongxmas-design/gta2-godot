extends CanvasLayer

# UI 요소
var player = null
var health_label = null
var ammo_label = null
var money_label = null
var minimap = null

# 게임 상태
var player_health = 100
var player_ammo = 120
var player_money = 0

func _ready():
	print("HUD initialized")
	await get_tree().process_frame
	find_player()
	create_ui_elements()

func _process(delta):
	if player:
		update_health_display()
		update_ammo_display()
		update_money_display()

func find_player():
	player = get_tree().get_first_child_in_group("player")
	if not player:
		player = get_parent().get_node_or_null("Player")
		if player:
			player.add_to_group("player")

func create_ui_elements():
	# 간단한 UI 레이블 생성
	var main_vbox = VBoxContainer.new()
	main_vbox.anchor_left = 0.0
	main_vbox.anchor_top = 0.0
	main_vbox.anchor_right = 0.2
	main_vbox.anchor_bottom = 0.3
	
	health_label = Label.new()
	health_label.text = "Health: 100/100"
	main_vbox.add_child(health_label)
	
	ammo_label = Label.new()
	ammo_label.text = "Ammo: 120"
	main_vbox.add_child(ammo_label)
	
	money_label = Label.new()
	money_label.text = "Money: $0"
	main_vbox.add_child(money_label)
	
	add_child(main_vbox)

func update_health_display():
	if player:
		if health_label:
			health_label.text = "Health: %d/100" % [int(player_health)]

func update_ammo_display():
	if ammo_label:
		ammo_label.text = "Ammo: %d" % [int(player_ammo)]

func update_money_display():
	if money_label:
		money_label.text = "Money: $%d" % [int(player_money)]

func set_player_health(health: int, max_health: int):
	player_health = health
	if health_label:
		health_label.text = "Health: %d/%d" % [health, max_health]

func set_player_ammo(ammo: int):
	player_ammo = ammo
	if ammo_label:
		ammo_label.text = "Ammo: %d" % [ammo]

func set_player_money(money: int):
	player_money = money
	if money_label:
		money_label.text = "Money: $%d" % [money]

func show_notification(message: String):
	print("Notification: ", message)
