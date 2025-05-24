extends Node2D


@export var ball_scene: PackedScene = preload("res://ball/ball.tscn")


var score_1: int = 0
var score_2: int = 0


@onready var score_label_1: Label = $UI/CanvasLayer/Score
@onready var score_label_2: Label = $UI/CanvasLayer/Score2


func _ready() -> void:
    spawn_ball()


func spawn_ball() -> void:
    var ball: Node = ball_scene.instantiate()
    add_child(ball)
    var window_size: Vector2 = DisplayServer.window_get_size()
    ball.global_position = Vector2(window_size.x/2, window_size.y/2)
    ball.connect("goal_left", _on_goal_left)
    ball.connect("goal_right", _on_goal_right)
    ball.connect("restart", _on_restart)


func _on_goal_left():
    score_2 += 1
    score_label_2.text = str(score_2)
    spawn_ball()


func _on_goal_right() -> void:
    score_1 += 1
    score_label_1.text = str(score_1)
    spawn_ball()


func _on_restart() -> void:
    spawn_ball()
