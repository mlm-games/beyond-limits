extends RigidBody2D
class_name StarterCar

@export var horsepower := 1000
@export var max_speed := 250
@export var fuel := 150: 
	set(val): 
		fuel = max(val, 0)
@export var turn_strength := 0.2

var is_engine_running := false

var direction := Vector2.RIGHT

var current_speed := 0

#func _ready() -> void:

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_left"):
		direction = direction.rotated(-turn_strength * delta)
	if Input.is_action_pressed("ui_right"):
		direction = direction.rotated(turn_strength * delta)
	
	if !is_engine_running:
		return
	
	current_speed = linear_velocity.length()
	if current_speed < max_speed:
		apply_central_force(transform.x * horsepower)
	fuel -= delta
	
	if fuel <= 0:
		is_engine_running = false

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	rotation = lerp_angle(rotation, direction.angle(), state.step * 10)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and fuel > 0:
		is_engine_running = true
	
