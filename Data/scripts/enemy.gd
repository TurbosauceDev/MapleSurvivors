extends CharacterBody2D

#region --- Variables ---
##On Ready Variables
@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var hurt_box = $hurt_box
@onready var hit_box = $hit_box

##Exported Variables
@export var movement_speed : float  = 40.0
@export var base_hp : int = 25
@export var base_mp : int = 10
@export var current_hp : int 
#endregion

func _ready():
	current_hp = base_hp

#region --- Move Towards Player ---
func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	#print(player.global_position)
	velocity = direction * movement_speed
	move_and_slide()
	
	if direction.x > 0.1 :
		sprite.flip_h = true
	elif direction.x < 0.1 :
		sprite.flip_h = false
#endregion

func _on_hurt_box_hurt(damage):
	current_hp -= damage
	if current_hp <= 0:
		queue_free()
