extends Area2D

@export var level : int = 1
@export var hp : int = 1
@export var speed : int  = 100
@export var damage : int = 5
@export var knockback : int = 100
@export var aoe_size : float = 1.0

var target : Vector2 = Vector2.ZERO
var angle : Vector2 = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			hp = 1
			speed = 100
			damage = 5
			knockback = 100
			aoe_size = 1 

func _physics_process(delta):
	position += angle * speed * delta

func enemy_hit(charge = 1):
	print("enemy hit!")
	hp -= charge
	if hp <= 0:
		queue_free()

func _on_magic_bolt_timer_timeout():
	queue_free()
