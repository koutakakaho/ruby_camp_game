module Bending
	class Director
	   	def initialize
	      	@font = Font.new(70)
	      	@bending_img = Image.load('images/badending.png')
	   	end 
	    
		def play(score)
			
		    Window.draw(0, 0, @bending_img)
		    Window.draw_font(60, 300, "残念！ スコアは#{score}です！" , @font, { color: [255,0,0]})
		    scene_transition(score)
	   	end

		private
	    def scene_transition(score)
	        Scene.move_to(:opening) if Input.key_down?(K_ESCAPE)
    	end    
	end
end
