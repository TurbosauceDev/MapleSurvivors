extends Area2D

#region --- Variables ---
@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0

@onready var collision = $collision
@onready var disableTimer = $disableTimer

signal hurt(damage, angle, knockback)
#endregion

#region --- Take Damage ---
func _on_area_entered(area):
	if area.is_in_group("attack"): #When area with group 'attack' enters hurtbox
		if not area.get("damage") == null: #check if it has a damage value
			
			match HurtBoxType: #if yes, match hurtbox type
				0: ##Cooldown
					collision.call_deferred("set" , "disabled" , true) #disable hurtbox collision
					disableTimer.start() #start timer
				
				1: ##HitOnce
					pass
				
				2: ##Disabled Hitbox
					if area.has_method("tempdisable"): #check if has method tempdisable
						area.tempdisable() #temp disable hitbox from hitbox.gd
			
			var damage = area.damage
			
			var angle : Vector2 = Vector2.ZERO
			var knockback = area.knockback_amount
			if not area.get("angle") == null:
				angle = area.angle 
			#if area.get("knockback") == 1:
				#knockback = area.knockback_amount
			
			emit_signal("hurt" , damage, angle, knockback) 
			#print(knockback, " , " , angle)
			
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)
				
	#emit hurt signal with damage amount found in hitbox (used within beginner.gd and enemy.gd)
#endregion

#region --- Timer ---
func _on_disable_timer_timeout(): #reenable collision
	collision.call_deferred("set" , "disabled" , false)
#endregion
