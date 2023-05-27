extends EStateAction
class_name AnimationManagerAction

signal animation_finished
signal animation_reset

@export var animation_manager: AnimationManager
@export var animation_name: String

var animation_direction: Vector2 = Vector2.ZERO

var computed_animation_name: String:
	get: return animation_name if animation_name != null else state.name

var started_animation_name: String = ""


func _ready() -> void:
	super()
	animation_manager.animation_finished.connect(_on_animation_finished)


func _on_state_entered() -> void:
	started_animation_name = computed_animation_name
	animation_manager.travel(started_animation_name)

	if animation_direction != Vector2.ZERO:
		animation_manager._on_direction_changed(animation_direction)
		animation_manager.sync_blend_position(started_animation_name, animation_direction)
		animation_manager.is_locked = true

func reset_animation() -> void:
	_on_state_exited()
	animation_reset.emit()

func _on_animation_finished(finished_animation_name: String) -> void:
	if !state.is_active or started_animation_name == "" or finished_animation_name != animation_name:
		return
	
	animation_finished.emit(finished_animation_name)

func _on_state_exited() -> void:
	started_animation_name = ""
	animation_manager.is_locked = false
	animation_direction = Vector2.ZERO
