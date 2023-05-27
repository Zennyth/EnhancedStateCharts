extends ETransition
class_name EDelayTransition

@export var delay_s: int = 1
@onready var timer: Timer = Timer.new()

func _ready():
    add_child(timer)

func _on_owner_entered() -> void:
    timer.timeout.connect(_on_event_triggered)
    timer.start(delay_s)

func _on_owner_exited() -> void:
    timer.stop()

    if timer.timeout.is_connected(_on_event_triggered):
        timer.timeout.disconnect(_on_event_triggered)