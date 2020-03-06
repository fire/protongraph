tool
extends ConceptNode


func _init() -> void:
	node_title = "Scale from noise"
	category = "Nodes"
	description = "Applies a random scaling to a set of nodes from a noise input"

	set_input(0, "Nodes", ConceptGraphDataType.NODE)
	set_input(1, "Noise", ConceptGraphDataType.NOISE)
	set_input(2, "Amount", ConceptGraphDataType.VECTOR)
	set_input(3, "Base scale", ConceptGraphDataType.VECTOR)
	set_output(0, "", ConceptGraphDataType.NODE)


func get_output(idx: int) -> Spatial:
	var nodes = get_input(0)
	var noise = get_input(1)
	var amount = get_input(2, Vector3.ZERO)
	var base = get_input(3, Vector3.ONE)

	if not nodes or not noise:
		return null

	for i in range(nodes.size()):
		var t = nodes[i].transform
		var origin = t.origin
		var noise_value = (noise.get_noise_3dv(origin) + 1.0) / 2.0
		t.origin = Vector3.ZERO
		t = t.scaled(base + (amount * noise_value))
		t.origin = origin
		nodes[i].transform = t

	return nodes
