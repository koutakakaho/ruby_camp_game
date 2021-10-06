class Scene
	@@scenes = {}
	@@current = nil
	@@score = 0
	#得点を入れる配列
	@@ranking = []

	def self.add(director, title)
		# シンボルにするメソッド＿
		@@scenes[title.to_sym] = director
	end

	def self.move_to (title, score= nil)
		@@current = title.to_sym
		@@score = score
	end

	def self.play	
		@@scenes[@@current].play(score = @@score)
		if score != nil
			@@ranking << score
		end
		#p @@ranking
	end

	def self.play_music
		@@scenes[@@current].play_music
	end

end