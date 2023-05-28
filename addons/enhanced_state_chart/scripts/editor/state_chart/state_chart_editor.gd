extends Control
class_name StateChartEditor

const GraphNodeStateScene = preload("res://addons/enhanced_state_chart/scenes/editor/state_chart/GraphNodeState.tscn")

@onready var graph_edit: GraphEdit = $GraphEdit

var root: EState
var test: String


func initialize() -> void:
    print("hello")
    clear_graph()
    draw_states()




func draw_states():
    for child in root.get_children():
        if !child is EState:
            continue
        
        var graph_node_state: GraphNodeState = GraphNodeStateScene.instantiate()
        graph_node_state.initialize_state(child)
        graph_edit.add_child(graph_node_state)

func clear_graph() -> void:
    for child in graph_edit.get_children():
        child.queue_free()