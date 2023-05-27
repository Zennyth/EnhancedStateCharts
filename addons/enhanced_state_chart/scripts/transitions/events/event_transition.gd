@tool
@icon("res://addons/enhanced_state_chart/icons/transitions/events/event.png")
extends ETransition
class_name EEventTransition

@export var event: EEvent


func _ready() -> void:
    if Engine.is_editor_hint():
        return

    assert(event != null, "Event transition needs an event configured.")
    event = event.initialize_event(self)

func _on_owner_entered() -> void:
    event.triggered.connect(_on_event_triggered)
    
func _on_owner_exited() -> void:
    event.triggered.disconnect(_on_event_triggered)
    


func is_equal_to(other: ETransition) -> bool:
    if not other is EEventTransition:
        return super(other)

    return event == other.event

func _get_configuration_warnings():
    var warnings = super()
    
    if event == null:
        warnings.append("The event is not configured.")
    
    return warnings