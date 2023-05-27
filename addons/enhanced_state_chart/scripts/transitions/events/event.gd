@icon("res://addons/enhanced_state_chart/icons/transitions/events/event.png")
extends Resource
class_name EEvent

signal triggered


@export_node_path("Node") var source_path: NodePath
@export var signal_name: String

var source: Node
var owner: Node


func initialize_event(_owner: Node, auto_connect: bool = true) -> EEvent:
    var new_event: EEvent = duplicate(true)

    new_event.owner = _owner
    new_event.resolve_source()

    if auto_connect:
        new_event.connect_event()

    return new_event

func connect_event() -> void:
    if source == null or !source.has_signal(signal_name):
        return
    
    source.get(signal_name).connect(_on_triggered)
    
func disconnect_event() -> void:
    if source == null or !source.has_signal(signal_name) or !source.get(signal_name).is_connected(_on_triggered):
        return
    
    source.get(signal_name).connect(_on_triggered)



func _on_triggered(_arg1 = null, _arg2 = null, _arg3 = null, _arg4 = null) -> void:
    triggered.emit() 

func resolve_source() -> void:
    if source_path == null:
        push_error("Event [" + signal_name + "] should have their source path configured.")

    source = owner.get_node_or_null(source_path)

func is_equal_to(other: EEvent) -> bool:
    return false