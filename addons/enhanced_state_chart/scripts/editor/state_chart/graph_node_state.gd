extends GraphNode
class_name GraphNodeState


var state: EState

func initialize_state(_state: EState) -> void:
	state = _state
	title = state.name
	size = Vector2(150, 100)
