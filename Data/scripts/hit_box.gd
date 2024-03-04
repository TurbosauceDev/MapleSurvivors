extends Area2D

#region --- Variables ---
@export var damage = 1
@onready var collision = $CollisionShape2D
@onready var disableTimer = $disableHitboxTimer
#endregion

#region --- Deal Damage ---
func tempdisable():
	collision.call_deferred("set" , "disabled" , true) #disable hitbox collision
	disableTimer.start()

func _on_disable_hitbox_timer_timeout():
	collision.call_deferred("set" , "disabled" , false) #reenable hitbox collision
#endregion
