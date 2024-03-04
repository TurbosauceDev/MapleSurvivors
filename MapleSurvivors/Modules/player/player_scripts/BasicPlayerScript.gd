extends CharacterBody2D

@onready var player_sprite = $player_sprite
@onready var player_audio = $PlayerAudio
@onready var player_anim = $PlayerAnim



#region -- Variables --
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var gravity = 1000
#@export var inventory_data: InventoryData
#endregion

#region -- Physics Process --
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		player_audio.play()
		player_anim.play("jump")
		

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x > 0:
			player_anim.play("walk")
		elif velocity.x <= 0:
			player_anim.play("stand")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
#endregion
