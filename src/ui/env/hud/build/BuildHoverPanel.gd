extends MarginContainer

var build_name setget set_build_name
var content setget set_content

var ResourceRequirementView = preload("./ResourceRequiementView.tscn")

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	rect_position = mouse_pos
	rect_position.y -= rect_size.y

func set_build_name(new_build_name):
	build_name = new_build_name
	_update_required_resources()

func set_content(new_content):
	if content: content.queue_free()
	content = new_content
	$panel/margin/vbox/content.add_child(content)
	_update_required_resources()

func _update_required_resources():
	if !build_name || !content: return
	# add required_resources.content
	var reqs = Build.builds[build_name].resource_requirements
	for i in range(reqs.size()):
		var req = ResourceRequirementView.instance()
		req.icon = Items.items[reqs[i].name].icon
		req.quantity = reqs[i].quantity
		$panel/margin/vbox/required_resources/content.add_child(req)
