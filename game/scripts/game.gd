extends Node2D


# TODO: AI goalkeeper (not perfect)


@export var ball_scene: PackedScene = preload("res://ball/ball.tscn")


@onready var score_label_1: Label = $UI/CanvasLayer/Score
@onready var score_label_2: Label = $UI/CanvasLayer/Score2
@onready var escape_menu: CanvasLayer = $EscapeMenu
@onready var sfx_audio_stream_player_2d: AudioStreamPlayer2D = $Audio/SFXAudioStreamPlayer2D


var score_1: int = 0
var score_2: int = 0
var ball: Node
var freed: bool = false


func _ready() -> void:
    spawn_ball()


func _process(delta: float) -> void:
    if Input.is_action_just_pressed(&'restart') and not Global.paused:
        ball.queue_free()
        spawn_ball()
    if Input.is_action_just_pressed(&'pause'):
        Global.paused = not Global.paused
        escape_menu.visible = not escape_menu.visible
        freed = not freed


func spawn_ball() -> void:
    if Global.paused:
        return

    ball = ball_scene.instantiate()
    add_child(ball)
    var window_size: Vector2 = DisplayServer.window_get_size()
    ball.global_position = Vector2(window_size.x/2, window_size.y/2)
    ball.connect("goal_left", _on_goal_left)
    ball.connect("goal_right", _on_goal_right)
    ball.connect("restart", _on_restart)


func _on_goal_left():
    if Global.paused:
        return

    sfx_audio_stream_player_2d.stop()
    sfx_audio_stream_player_2d.stream = Audio.get_random_goal_audio()
    sfx_audio_stream_player_2d.play()

    score_2 += 1
    score_label_2.text = str(score_2)

    spawn_ball()


func _on_goal_right() -> void:
    if Global.paused:
        return

    sfx_audio_stream_player_2d.stop()
    sfx_audio_stream_player_2d.stream = Audio.get_random_goal_audio()
    sfx_audio_stream_player_2d.play()

    score_1 += 1
    score_label_1.text = str(score_1)

    spawn_ball()


func _on_restart() -> void:
    if Global.paused:
        return

    spawn_ball()


func _on_reset_button_pressed() -> void:
    score_1 = 0
    score_label_1.text = str(score_1)

    score_2 = 0
    score_label_2.text = str(score_2)

    if not freed:
        freed = true
        ball.queue_free()
        spawn_ball()
