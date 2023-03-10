extends CharacterBody2D

@export var move_speed : float = 100;

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")


func _ready():
	update_walking_animation(Vector2(0, 0))

func _physics_process(delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"),
	).normalized()
	
	update_walking_animation(input_direction)

	velocity = input_direction * move_speed
	
	move_and_slide()


func update_walking_animation(direction : Vector2):
	if direction == Vector2.ZERO:
		state_machine.travel("idle")
		
	else:
		animation_tree.set("parameters/walk/blend_position", direction)
		animation_tree.set("parameters/idle/blend_position", direction)
		state_machine.travel("walk")
