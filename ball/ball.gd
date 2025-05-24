extends RigidBody2D


@export var speed: int = 500
@export var speed_increment: int = 10
@export var ball_toss_angle_threshold_deg: int = 75


var angle: int
signal goal_left
signal goal_right
signal restart


func _ready() -> void:
    launch_ball()


func _process(delta: float) -> void:
    if Input.is_action_just_pressed(&"restart"):
        emit_signal(&"restart")
        queue_free()


func _physics_process(delta: float) -> void:
    speed += delta * speed_increment

    var movement: Vector2 = Vector2.ZERO

    movement.x = speed * sin(angle)
    movement.y = speed * cos(angle)

    var collision: KinematicCollision2D =  move_and_collide(movement * delta)
    if collision == null:
        return
    var collider: PhysicsBody2D = collision.get_collider()
    if not is_instance_valid(collider):
        return
    if collider.name.contains(&"Goal"):
        emit_signal(&"goal_right" if collider.name.contains(&"Goal2") else &"goal_left")
        queue_free()
    elif collider.name.contains(&"Paddle"):
        var reflected: Vector2 = movement.bounce(collision.get_normal())
        angle = atan2(reflected.x, reflected.y)
    elif collider.name.contains(&"Wall"):
        var reflected = Vector2(movement.x, -movement.y)
        angle = atan2(reflected.x, reflected.y)


func launch_ball():
    randomize()
    var direction = randi() % 2
    var angle_deg: float

    if direction == 0:
        angle_deg = randf_range(ball_toss_angle_threshold_deg, 180 - ball_toss_angle_threshold_deg)
    else:
        angle_deg = randf_range(180 + ball_toss_angle_threshold_deg, 360 - ball_toss_angle_threshold_deg)

    angle = deg_to_rad(angle_deg)
