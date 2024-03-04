extends CharacterBody2D

#region --- Variables ---
##On Ready Variables
@onready var sprite = $player_sprite
@onready var player_anim = $PlayerAnim
#@onready var playerStats : Array = [current_hp , current_mp]

##Exported Variables
@export var base_speed : float = 420.69
@export var base_hp : int = 100
@export var current_hp : int 
@export var base_mp : int = 100
@export var current_mp : int 
@export var base_str : int = 5
@export var base_int : int = 5
@export var base_dex : int = 5
@export var base_wis : int = 5
@export var base_con : int = 5
##Variables


#endregion

func _ready():
	
	current_hp = base_hp
	current_mp = base_mp
	#print("HP: ", playerStats[0], " , ", "MP: ", playerStats[1])

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

#region --- Animation ---
func animate():
	
	if velocity:
		player_anim.play("walk")
	else:
		player_anim.play("stand")
#endregion

#region --- Take Damage --- 
func _on_hurt_box_hurt(damage):
	current_hp -= damage
	var playerStats : Array = [current_hp , current_mp]
	print("HP: ", playerStats[0], " , ", "MP: ", playerStats[1])
	#print(current_hp)

#endregion
