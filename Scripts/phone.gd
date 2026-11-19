extends Node3D

@export var player_camera: Camera3D
@export var screen_camera: Camera3D
@export var decal1: Decal
@export var decal2: Decal
@export var sub_viewport: SubViewport
@onready var screen_viewport: SubViewport = $SubViewport
@onready var screen_mesh: MeshInstance3D = $MeshInstance3D

var tween: Tween

func _ready() -> void:
	if player_camera == null:
		player_camera = get_viewport().get_camera_3d()

	screen_viewport.size = Vector2i(256, 256)
	screen_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	screen_viewport.world_3d = get_world_3d()

	# Layer 20: the screen is visible to the player, but not to its own camera.
	screen_mesh.layers = 1 << 19
	screen_mesh.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	screen_camera.cull_mask &= ~(1 << 19)
	screen_camera.make_current()

	var material = StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_texture = screen_viewport.get_texture()
	screen_mesh.material_override = material

	if player_camera == null:
		push_warning("Phone: assign player_camera before running this scene.")
		set_process(false)

func _process(_delta: float) -> void:
	screen_camera.global_transform = player_camera.global_transform
	screen_camera.fov = player_camera.fov
	screen_camera.near = player_camera.near
	screen_camera.far = player_camera.far
	
func take_screen():
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	
	if sub_viewport.render_target_update_mode == SubViewport.UPDATE_ALWAYS:
		tween.tween_property(decal1,'position',Vector3(0,0,0),0.1)
		await tween.parallel().tween_property(decal2,'position',Vector3(0,0,0),0.1)
		sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
		tween.tween_property(decal1,'position',Vector3(0,0,2),0.1)
		tween.parallel().tween_property(decal2,'position',Vector3(0,0,-2),0.1)
	else:
		sub_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
