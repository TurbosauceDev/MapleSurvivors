extends Area2D

@export var meso = 1
@onready var meso_col = $meso_col
@onready var meso_anim = %meso_anim
@onready var meso_sprite = $meso_sprite

var target = null
var speed = -3

func _ready():
	if meso < 50:
		%meso_anim.play("meso_coin_copper")
	elif meso < 200:
		%meso_anim.play("meso_coin_gold")
	elif meso < 500:
		%meso_anim.play("meso_stack")
	else:
		%meso_anim.play("meso_bag")

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 10*delta

func collect():
	meso_col.call_deferred("set" , "disabled" , true)
	meso_sprite.visible = false
	
	return meso

