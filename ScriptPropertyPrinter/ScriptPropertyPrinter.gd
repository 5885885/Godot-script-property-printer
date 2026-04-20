class_name ScriptProperyPrinter
extends Node

# Can be used to print properties for nodes, to track progress and avoid getting drowned
# in prints such as when using the _process function for prints.
# Can not reliably access preexisting properties like process_mode.
# Can not access properties tied to internal functions. 
# Can access properties defined in scripts, like vars and exports.
# Can access runtime properties like velocity, state and rotation.

@onready var timer: Timer = $Timer

@export var wait_time: float = 1.0
@export var properties_to_print: Array[StringName]
@export var node_to_print_for: Node

func _ready() -> void:
	timer.wait_time = wait_time

func _on_timer_timeout() -> void:
	if node_to_print_for != null:
		for property in properties_to_print:
			if node_to_print_for.get(property):
				print("%s's %s: %s" % [node_to_print_for.name, property, node_to_print_for.get(property)])
			elif !node_to_print_for.get(property):
				print("%s either does not have property %s" % [node_to_print_for.name, property])
				print("or the property is an engine internal property not detected by this tool.")
	else:
		print("Assign a node to print for.")
