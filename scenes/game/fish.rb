class Fish < CPBox 
	attr_accessor :x , :y
	COLLISION_TYPE = 10

	def initialize(x, y, mass, e = 2, u = 0)		
		image = Image.load("images/kingyo_top.png")
		super x, y, image.width ,image.height ,mass, C_WHITE, e, u
		self.x = x
		self.y = y
		@image = image
		@body.v = CP::Vec2.new(rand(300)-150,rand(300)-150)
		#@body.apply_impulse(CP::Vec2.new(30,30), CP::Vec2.new(0,0))
		# apply_force(30,30)と同じ意味
		@shape.collision_type = self.class::COLLISION_TYPE 
		@caught = false
 	end

	def move(loop_count) 
		apply_force(10,10)
     	if loop_count % 5 == 0
		    apply_force(-@body.p.x / 2, 0)
        elsif loop_count % 10 == 0
			apply_force(0, -@body.p.y / 2 )
        elsif (loop_count % 260 + rand(50)) == 0
			apply_force(0, -@body.p.y / 2 + 200)
		end

		if @body.p.x > Window.width - 30
			@body.v = CP::Vec2.new(rand(100)-200, rand(300)- 150)
		elsif @body.p.x <  30
			@body.v = CP::Vec2.new(rand(100), rand(300)-150)
		elsif @body.p.y > Window.height - 30
			@body.v = CP::Vec2.new(rand(100), rand(300))
		elsif @body.p.y < 30
			@body.v = CP::Vec2.new(rand(300), rand(100))
		end
	end

 #　プレイヤにダメージを与える
	
	def attack
		# if(処理)
				#player_HP -= 5
		#	else
	end

	#魚同士がよける処理
	def avoid
		@body.v *= 1.0001
	end

	#　すくわれたときに画像を変換する
	def caught
		@caught = true
	end

	def caught?
		@caught
	end

	private

	def apply_force(x,y)
		body.apply_impulse(CP::Vec2.new(x,y),CP::Vec2.new(0, 0))
	end
end