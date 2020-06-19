extends KinematicBody2D

signal died

func _ready():
	$sprite.play('waiting')
