@tool
extends EditorPlugin

const AUTOLOAD_NAME: StringName = "CQRS"

func _enter_tree() -> void:
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/cqrs/CQRS.tscn")

func _exit_tree() -> void:
	remove_autoload_singleton(AUTOLOAD_NAME)
