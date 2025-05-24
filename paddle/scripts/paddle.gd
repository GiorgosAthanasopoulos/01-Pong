extends CharacterBody2D


@export var left: bool = true
# PHYSICS
@export var speed: float = 400
# COLORS
@export var COLOR_LEFT: Color = Color(1, 0, 0, 1)
@export var COLOR_RIGHT: Color = Color(0, 0, 1, 1)
# AI
@export var ai: bool = true
@export var ai_perfect: bool = true
@export var reaction_delay: float = 0.15
@export var error_margin: float = 10.0


@onready var color_rect: ColorRect = $ColorRect
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var target_y: float
var reaction_timer := 0.0


func _ready() -> void:
    color_rect.color = COLOR_LEFT if left else COLOR_RIGHT


func _process(delta: float) -> void:
    if Global.paused:
        return

    if ai:
        handle_ai_movement(delta)
    else:
        move_and_collide(handle_player_movement() * delta)


func handle_ai_movement(delta: float) -> void:
    var ball: Node = get_node("/root/Game/Ball")
    if not ball:
        ball = get_node("/root/Game/Ball2")
    if not ball:
        return
    var ball_position = ball.position

    if ai_perfect:
        position.y = ball_position.y
    else:
        reaction_timer -= delta

        if reaction_timer <= 0.0:
            target_y = ball.global_position.y + randf_range(-error_margin, error_margin)
            reaction_timer = reaction_delay

        var direction = sign(target_y - global_position.y)
        var velocity_y = direction * speed
        velocity.y = velocity_y

        move_and_slide()


func handle_player_movement() -> Vector2:
    var movement: Vector2 = Vector2.ZERO

    if left:
        if Input.is_action_pressed(&"p1_move_up"):
            movement.y = -speed
        if Input.is_action_pressed(&"p1_move_down"):
            movement.y = speed
    else:
        if Input.is_action_pressed(&"p2_move_up"):
            movement.y = -speed
        if Input.is_action_pressed(&"p2_move_down"):
            movement.y = speed

    return movement
