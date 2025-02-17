class_name CommandHelper

const COMMAND_HANDLER_NAME = &"CommandHandler"
const COMMAND_NAME = &"Command"

static var command_handler_info_dict : Dictionary[StringName, CommandHandler] = {}
static var command_info_dict : Dictionary[StringName, Variant] = {}


static func _static_init() -> void:
	for class_dict in  ProjectSettings.get_global_class_list():
		if class_dict.base == COMMAND_HANDLER_NAME:
			command_handler_info_dict[class_dict.class] = load(class_dict.path).new()
		if class_dict.base == COMMAND_NAME:
			command_info_dict[class_dict.class] = load(class_dict.path)

static func get_method_info(object: Object, method_name: StringName) -> Dictionary:
	var method_list: Array[Dictionary] = object.get_method_list()
	for method: Dictionary in method_list:
		if method.name == method_name:
			return method
	return {}
