require_relative "cp_circle"

class Player < CPCircle
	attr_accessor :x , :y
	COLLISION_TYPE = 2

	def move
	    apply_force(0, 0)
	    apply_force(50, 0) if Input.key_down?(K_RIGHT)
	    apply_force(-50, 0) if Input.key_down?(K_LEFT)
	    apply_force(0, -50) if Input.key_down?(K_UP)
	    apply_force(0, 50) if Input.key_down?(K_DOWN)
  	end
end