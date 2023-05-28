@tool
extends EditorPlugin

const StateChartEditorScene = preload("res://addons/enhanced_state_chart/scenes/editor/state_chart/StateChartEditor.tscn")

var state_chart_editor: StateChartEditor
var is_in_bottom_panel: bool = false

const EventEditorInspector = preload("res://addons/enhanced_state_chart/scripts/editor/events/event_editor_inspector.gd")
var event_editor_inspector: EditorInspectorPlugin

func _enter_tree():
	state_chart_editor = StateChartEditorScene.instantiate() as StateChartEditor

	event_editor_inspector = EventEditorInspector.new()
	add_inspector_plugin(event_editor_inspector)

	scene_changed.connect(_on_scene_changed)


func _exit_tree():
	scene_changed.disconnect(_on_scene_changed)
	remove_inspector_plugin(event_editor_inspector)



func _on_scene_changed(scene_root: Node) -> void:
	var root: EState = get_state_chart_node(scene_root)

	if root != null and !is_in_bottom_panel:
		add_control_to_bottom_panel(state_chart_editor, "State Charts")
		state_chart_editor.root = root
		is_in_bottom_panel = true
	else:
		remove_control_from_bottom_panel(state_chart_editor)
		is_in_bottom_panel = false


func get_state_chart_node(node: Node) -> EState:
	if node is EState:
		return node as EState
	
	for child in node.get_children():
		var state := get_state_chart_node(child)

		if state != null:
			return state
	
	return null