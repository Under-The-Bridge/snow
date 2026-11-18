extends Decal

func _ready() -> void:
	$CPUParticles3D.restart()
	$CPUParticles3D.emitting = true
