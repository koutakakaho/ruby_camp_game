#同じディレクトリ内にあるファイルを読み込めるようにする
require_relative "player"
require "time"
module Game
	class Director

		def initialize()
			#ひとつ目の空間
			@space_fish = CP::Space.new
	    	@space_fish.gravity = CP::Vec2.new(0, 0)

	    	#二つ目の空間
	    	@space_poi = CP::Space.new
	    	@space_poi.gravity = CP::Vec2.new(0,0)

			@fishes = []
			@font = Font.new(32)
			@score = 0
			@limit_time = 60
			@loop_count = 1
			@time = Time.now

			#背景画像の読みk身
			@back_iamge = Image.load("images/back.png")
			#ポイ（プレイヤ）の作成
			@image1 = Image.load("images/poi1.png")
			#別のところで使いたいのでインスタンス変数にしておく
			@image2 = Image.load("images/poi2.png")
			#ゲーム時の音楽を読み込む
			@game_music = Sound.new("sounds/opening.mid")
			#@game_music.play
			#残り時間が少なくなった時の音楽を読み込む
			@danger_music = Sound.new("sounds/danger.mid")
			#通常のポイを作成
			@player= Player.new(30,300,50,10, @image1)
			#物理空間にッ登録
			@space_poi.add(@player)
			#　1から10までの数の金魚を発生させる
			(rand(12)+8).times do
				fish = Fish.new(
				  rand(600)+100,
				  rand(400)+100,
				  40
				)
				@space_fish.add(fish)
				@fishes << fish
			end
			#　ステージの壁の作成
			CPBase.generate_walls(@space_fish, Window.width,Window.height)

			#　衝突処理
			@space_fish.add_collision_handler(Fish::COLLISION_TYPE, Fish::COLLISION_TYPE) do |a, b, arb|
		     # 衝突個所（arb.points配列）から、先頭の1つを取得（複数個所ぶつかるケースもあり得るため配列になっている）
		    	pos = arb.points.first.point
		     # 衝突個所の座標に絵を表示（1フレームで消える点に留意）
		     	#sound = Sound.new("適当なファイル")
		    	#sound.play
		    end
	    end

		def play(score= nil)

			Window.draw(0,0,@back_iamge)
			@player.move
			@player.draw

			list = []
			
			@fishes.each do |fish|
				x = @player.body.p - fish.body.p
				if x.length < 70
				#ここでしか使わないのでローカル変数を使う
					player2 = Player.new(@player.body.p.x-@player.r, @player.body.p.y-@player.r, 10, 50, @image2)
					player2.draw
					if Input.key_down?(K_SPACE)#ボタンが押されたら
						#金魚を消す処理
						@score += 10
						fish.caught
						@space_fish.remove(fish)
					end
				end

				@fishes.each do |fish2|
					dist = (fish.body.v - fish2.body.v).length
					list << dist
					#配列の最初スチガ何番目かを検知
					x = list.find_index(list.min)
				end
				#最も距離の短い魚が逃げる仕様？
				@fishes[x].avoid
			
				fish.draw
				fish.move(@loop_count)
			end

			#fishesから削除
			@fishes.reject! {|fish| fish.caught?}

			#距離の配列
			

			#スコアと時間の表示
			Window.draw_font(0, 0, "スコア：#{@score}, 時間:#{@limit_time}, ", @font)

			@space_fish.step( 1 / 60.0 )
			@space_poi.step( 1 / 60.0 )

			@loop_count += 1
			if @loop_count % 30 == 0
				@limit_time -= 1
			end

			#@game_music.play
			#終了処理
			scene_transition
		end

		def play_music
			@game_music.loop_count = 2
			@game_music.play
		end

	  	def draw
	    	Window.draw_rot(@body.p.x - @r, @body.p.y - @r, @image, @body.p.to_angle * 360.0 )
	  	end

	  	private
	  	def scene_transition
	  		if @score >= 100
  				Scene.move_to(:ending, @score)
  				@score = 0
  				@limit_time = 100
  				@player= Player.new(30,300,50,10, @image1)
				@space_poi.add(@player)
  			elsif @limit_time <= 0
				Scene.move_to(:bending, @score) 
				@score = 0
				@limit_time = 100
				@player= Player.new(30,300,50,10, @image1)
				@space_poi.add(@player)
    		end
    	end
	end
end