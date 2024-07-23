extends CharacterBody2D


const SPEED = 5000.0
const JUMP_VELOCITY = -400.0

@onready var wall_detector := $wall_detector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var damage_sfx = $player_sounds/damage_sfx as AudioStreamPlayer


var direction := -1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var seguranca_life = 5

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
		texture.flip_h = !texture.flip_h

	velocity.x = direction * SPEED * delta

	move_and_slide()

func decrementar_seguranca():
	seguranca_life = seguranca_life -1
	var color_seguranca_tween := get_tree().create_tween()
	damage_sfx.play()
	texture.modulate = Color(1, 0, 0, 1)
	color_seguranca_tween.parallel().tween_property(texture, "modulate", Color(1, 1, 1, 1), 0.35)