class_name ScriptProperyPrinter
extends Node

# Can be used to print properties for nodes, to track progress and avoid getting drowned
# in prints such as when using the _process function for prints.
# Can not reliably make correct prints for internal properties.
# Can access properties defined in scripts, like vars and exports.
# Can access runtime properties like velocity, state and rotation.

@onready var timer: Timer = $Timer

@export var wait_time: float = 1.0

## StringNames of properties to print. 
@export var properties_to_print: Array[StringName]

## The node to print the properties for.
@export var node_to_print_for: Node

func _ready() -> void:
	timer.wait_time = wait_time

func _on_timer_timeout() -> void:
	if node_to_print_for != null:
		for property in properties_to_print:
			if node_to_print_for.get(property) != null:
				print("%s's %s: %s" % [node_to_print_for.name, property, node_to_print_for.get(property)])
			elif !node_to_print_for.get(property):
				print("Can't find property %s" % [property])
	else:
		push_error("Assign a node to print for.")
