extends CharacterBody2D


@export var left: bool = true
@export var speed: float = 400
@export var COLOR_LEFT: Color = Color(1, 0, 0, 1)
@export var COLOR_RIGHT: Color = Color(0, 0, 1, 1)


@onready var color_rect: ColorRect = $ColorRect


func _ready() -> void:
    color_rect.color = COLOR_LEFT if left else COLOR_RIGHT


func _process(delta: float) -> void:
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

    move_and_collide(movement * delta)
