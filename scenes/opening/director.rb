module Opening
	class Director
		def initialize
			#文字サイズを決める
			@font = Font.new(100)
			@o_image = Image.load("images/opening2.png")
			@op_music = Sound.new("sounds/festival.mid")
			@op_music.play
		end

		def play(score= nil)
			#音楽の再生回数を指定
			# @start = 1
			# #実際に音楽を流す
			# if @start > 0
				
			# 	@op_music.stop
			# 	@start -= 1
			# end
			#背景画像を描画
			Window.draw(0, 0, @o_image)
			#タイトル文字の描画
			Window.draw_font(40, 250, "金魚すくいゲーム", @font, {color: [0,0,0]})
			scene_transaction
		end

		def play_music
			@op_music.loop_count = 2
			@op_music.play
		end

		private
		def scene_transaction
			Scene.move_to(:game) if Input.key_push?(K_ESCAPE) 
		end
	end
end