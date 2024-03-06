extends CharacterBody2D

#region --- Variables ---
##On Ready Variables
@onready var sprite = $player_sprite
@onready var player_anim = $PlayerAnim
#@onready var xp_bar = %xp_bar
#@onready var level_label = %level_label
@onready var xp_bar = $GUIController/MenuController/EXPMenuController/xp_container/xp_bar
@onready var level_label = $GUIController/MenuController/EXPMenuController/xp_container/xp_bar/level_label


##Exported Variables
@export_category("Base Stats")
@export var base_speed : float = 420.69
@export var base_hp : int = 100
@export var base_mp : int = 100
@export var base_str : int = 5
@export var base_int : int = 5
@export var base_dex : int = 5
@export var base_wis : int = 5
@export var base_con : int = 5

@export_category("Current Stats")
@export var current_hp : int 
@export var current_mp : int 

@export_category(" - XP - ")
@export var xp = 0
@export var xp_level = 1
@export var collected_xp = 0
#endregion

#region --- Attacks ---
##MagicBolt
var MagicBolt = preload("res://Modules/player/player_skills/mage_skills/magic_bolt.tscn")

@onready var MagicBolt_timer = %MagicBoltTimer
@onready var MagicBolt_attacktimer = %MagicBoltAttackTimer

@export_category("Magic Bolt")
@export var MagicBolt_ammo = 1 
@export var MagicBolt_base_ammo = 4
@export var MagicBolt_attack_speed = 1.5
@export var MagicBolt_level = 1
#endregion

#region --- Enemy Related ---
var enemy_close = []
#endregion

#region --- Ready ---
func _ready():
	attack()
	current_hp = base_hp
	current_mp = base_mp
	set_xp_bar(xp, calculate_xp_cap())
	#print("HP: ", playerStats[0], " , ", "MP: ", playerStats[1])
#endregion

#region --- Movement ---
func _physics_process(_delta):
	movement()

func movement():
	
	var x_direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_direction = Input.get_action_strength("down") - Input.get_action_strength("up")
	var direction = Vector2(x_direction, y_direction)
	
	velocity = direction.normalized() * base_speed
	
	if x_direction == 1:
		sprite.flip_h = false
	elif x_direction == -1:
		sprite.flip_h = true
	
	move_and_slide()
	animate()
#endregion

#region --- Attacking ---
func attack():
	if MagicBolt_level > 0:
		MagicBolt_timer.wait_time = MagicBolt_attack_speed
		if MagicBolt_timer.is_stopped():
			MagicBolt_timer.start()
#endregion

#region --- Animation ---
func animate():
	
	if velocity:
		player_anim.play("walk")
	else:
		player_anim.play("stand")
#endregion

#region --- Take Damage --- 
func _on_hurt_box_hurt(damage, _angle, _knockback_amount):
	
	current_hp -= damage
	var playerStats : Array = [current_hp , current_mp]
	print("HP: ", playerStats[0], " , ", "MP: ", playerStats[1])
	#print(current_hp)
#endregion

#region --- Magic Bolt ---
func _on_magic_bolt_timer_timeout():
	MagicBolt_ammo += MagicBolt_base_ammo
	MagicBolt_attacktimer.start()

func _on_magic_bolt_attack_timer_timeout():
	if MagicBolt_ammo > 0:
		var MagicBolt_attack = MagicBolt.instantiate()
		MagicBolt_attack.position = position
		MagicBolt_attack.target = get_random_target()
		MagicBolt_attack.level = MagicBolt_level
		add_child(MagicBolt_attack)
		MagicBolt_ammo -= 1
		#print(enemy_close)
		if MagicBolt_ammo > 0:
			MagicBolt_attacktimer.start()
		else:
			MagicBolt_attacktimer.stop()
#endregion

#region --- Enemy Targeting ---
func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

func _on_enemy_detection_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)
		#print("Slime Spotted!")

func _on_enemy_detection_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)
		#print("Slime Slimed!")
#endregion

#region --- Looting ---
func _on_grab_area_area_entered(area): #grab loot
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area): #collect loot
	if area.is_in_group("loot"):
		var meso_amount = area.collect()
		calculate_xp(meso_amount)
#endregion

#region --- XP ---
func calculate_xp(meso_amount):
	var xp_required = calculate_xp_cap()
	collected_xp += meso_amount
	if xp + collected_xp >= xp_required: ##Level Up
		collected_xp -= xp_required - xp
		xp_level += 1
		print("Level:", xp_level)
		level_label.text = str("Level: ", xp_level )
		xp = 0
		xp_required = calculate_xp_cap()
		calculate_xp(0)
	else:
		xp += collected_xp
		collected_xp = 0
	
	set_xp_bar(xp, xp_required)

func calculate_xp_cap():
	var xp_cap = xp_level
	if xp_level < 20:
		xp_cap = xp_level * 5
	elif xp_level < 40:
		xp_cap + 95 * (xp_level -19) * 8
	else:
		xp_cap = 255 + (xp_level - 39) * 12
		
	return xp_cap

func set_xp_bar(set_value = 1, set_max_value = 100):
	xp_bar.value = set_value
	xp_bar.max_value = set_max_value
#endregion
