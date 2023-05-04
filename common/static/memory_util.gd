class_name MemoryUtil
extends RefCounted


static func safe_free(any) -> void:
	if any is RefCounted or not is_instance_valid(any):
		return

	if any is Node:
		any.queue_free()

	elif any is Object:
		any.free()

	# Other types don't need specific attention.
