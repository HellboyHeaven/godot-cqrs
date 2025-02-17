extends Node

const EXECUTE_METHOD_NAME: StringName = "execute"

var command_handlers : Dictionary[GDScript, CommandHandler] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_register_commands()

func execute(command: Command):
	var handler : CommandHandler = command_handlers[command.get_script()]
	var method_info = CommandHelper.get_method_info(handler, EXECUTE_METHOD_NAME);
	var callable: Callable = Callable(handler, EXECUTE_METHOD_NAME);
	return callable.call(command)

func _register_commands() :
	command_handlers.clear()
	for handler : CommandHandler in CommandHelper.command_handler_info_dict.values():
		var method_info = CommandHelper.get_method_info(handler, EXECUTE_METHOD_NAME)
		var parameters: Array[Dictionary] = method_info.args
		if parameters.size() != 1:
			push_error("cqrs.register_commands: "+ handler.get_script().resource_path +" require only one params in handler method")
		var command_name : StringName = parameters[0].class_name
		if not CommandHelper.command_info_dict.has(command_name):
			continue
		var command : GDScript = CommandHelper.command_info_dict[command_name]
		if (command_handlers.has(command)):
			push_error("cqrs.register_commands: One command refers to multiple handlers")
		command_handlers[command] = handler
