extends KinematicBody2D

signal attack

func attack(damage):
	emit_signal('attack', damage)
