extends StaticBody2D

signal attack(damage)

func attack(damage):
	emit_signal('attack', damage)
