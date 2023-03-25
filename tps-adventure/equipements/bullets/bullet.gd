extends CharacterBody3D

const BULLET_VELOCITY = 500
const damage_bonus = 10
@onready var collision_shape = $BulletCollision
var time_alive = 5
var hit = false

@onready var animation_player = $AnimationPlayer
func _physics_process(delta):
	if hit:
		collision_shape.disabled = true
		return
	time_alive -= delta
	if time_alive < 0:
		hit = true
		self.queue_free()
		#animation_player.play("explode")
	move_and_collide(-delta * BULLET_VELOCITY * transform.basis.z)


func _on_bullet_hit_area_area_entered(area):
	if area.has_method("make_damage") and area.is_in_group("enemy_part"):
		area.make_damage(damage_bonus)
		self.queue_free()
