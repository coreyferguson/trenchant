extends Node

var health
var health_capacity

func add_health(amount):
	health = clamp(health+amount, 1, health_capacity)

func reset_state():
	health = 5
	health_capacity = 5
