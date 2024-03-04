extends CharacterBody2D

#region --- Variables ---
##On Ready Variables
@onready var sprite = $player_sprite
@onready var player_anim = $PlayerAnim

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

func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var meso_amount = area.collect()
		
