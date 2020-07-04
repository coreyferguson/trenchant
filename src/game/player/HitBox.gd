extends StaticBody2D

signal attack

func attack(damage):
	emit_signal('attack', damage)
