@tool
extends Button

const SignalPicker = preload("res://addons/enhanced_state_chart/scenes/editor/SignalPicker.tscn")

var transition: ETransition
var signal_picker

func initialize(_transition: ETransition) -> void:
    transition = _transition
    pressed.connect(_on_pressed)


func _on_pressed() -> void:
    if transition.event == null:
        transition.event = EEvent.new()
        return
    
    signal_picker = SignalPicker.instantiate()
    signal_picker.initialize(transition.get_node(transition.event.source_path))
    signal_picker.signal_picked.connect(_on_signal_picked)
    add_child(signal_picker)


func _on_signal_picked(signal_name: String, node: Node) -> void:
    transition.event.signal_name = signal_name 
    signal_picker.close()
