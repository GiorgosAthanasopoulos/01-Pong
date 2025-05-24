extends Node

const goal_1: AudioStreamWAV = preload('res://assets/sounds/goal/trimmed/36796__alexpadina__goal1.wav')
const goal_3: AudioStreamWAV = preload('res://assets/sounds/goal/trimmed/36798__alexpadina__goal3.wav')
const goal_5: AudioStreamWAV = preload('res://assets/sounds/goal/trimmed/36800__alexpadina__goa5.wav')
const goal_6: AudioStreamWAV = preload('res://assets/sounds/goal/trimmed/36801__alexpadina__goal6.wav')
const ball_hit: AudioStreamWAV = preload('res://assets/sounds/hit/trimmed/269718__michorvath__ping-pong-ball-hit.wav')


func get_random_goal_audio() -> AudioStreamWAV:
    var choice: int = randi() % 4
    if choice == 0:
        return goal_1
    if choice == 1:
        return goal_3
    if choice == 2:
        return goal_5
    else:
        return goal_6


func get_ball_hit_audio() -> AudioStreamWAV:
    return ball_hit
