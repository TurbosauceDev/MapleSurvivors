extends CharacterBody2D

#region --- Variables ---
##On Ready Variables
@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var hurt_box = $hurt_box
@onready var hit_box = $hit_box
@onready var slime_anim = $slime_anim


##Exported Variables
@export_category("Stats")
@export var movement_speed : float  = 40.0
@export var knockback_recovery : float = 0
@export var base_hp : int = 25

var current_hp : int 
var knockback : Vector2 = Vector2.ZERO
#endregion

func _ready():
	current_hp = base_hp

#region --- Move Towards Player ---
func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	#print(player.global_position)
	velocity = direction * movement_speed
	velocity += knockback
	move_and_slide()
	
	if direction.x > 0.1 :
		sprite.flip_h = true
	elif direction.x < 0.1 :
		sprite.flip_h = false
#endregion

func _on_hurt_box_hurt(damage, angle, knockback_amount):
	current_hp -= damage
	knockback = angle * knockback_amount
	if current_hp <= 0:
		slime_anim.play("death")
		#queue_free()
