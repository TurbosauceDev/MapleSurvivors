extends CharacterBody2D

#region --- Variables ---
##On Ready Variables
@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var sprite = $Sprite2D
@onready var hurt_box = $hurt_box
@onready var hit_box = $hit_box
@onready var slime_anim = $slime_anim
 
var meso_scene = preload("res://Scenes/utility/meso_bag.tscn")

##Exported Variables
@export_category("Stats")
@export var movement_speed : float  = 40.0
@export var knockback_recovery : float = 0
@export var base_hp : int = 25
@export var xp = 1

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

func death():
	#emit_signal("remove_from_array", self)
	slime_anim.play("death")
	var new_meso = meso_scene.instantiate()
	new_meso.global_position = global_position
	new_meso.meso = xp 
	loot_base.call_deferred("add_child", new_meso)
	queue_free()


func _on_hurt_box_hurt(damage, angle, knockback_amount):
	current_hp -= damage
	knockback = angle * knockback_amount
	if current_hp <= 0:
		death()
		
