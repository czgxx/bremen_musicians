# ShaderManager.gd (放在Autoload)
extends Node
#class_name ShaderManager

var shader_cache: Dictionary = {}

func get_card_shader(shader_name: String) -> Shader:
	if shader_cache.has(shader_name):
		return shader_cache[shader_name]
	
	var path = "res://card/card_shader/shaders/" + shader_name + ".gdshader"
	if ResourceLoader.exists(path):
		var shader = load(path)
		shader_cache[shader_name] = shader
		return shader
	
	push_error("Shader not found: " + path)
	return null

func apply_card_shader(card_node: Node, shader_name: String, params: Dictionary):
	var shader = get_card_shader(shader_name)
	if not shader:
		return
	
	var material = ShaderMaterial.new()
	material.shader = shader
	
	# 批量设置参数
	for key in params:
		material.set_shader_parameter(key, params[key])
	
	card_node.material = material
