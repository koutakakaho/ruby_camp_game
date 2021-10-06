require "dxruby"
require "chipmunk"

#　関連するサイズを読み込み
require_relative "scenes/game/cp"
require_relative "scenes/game/cp_static_box"
require_relative "scenes/game/director"
require_relative "scenes/game/cp_box"
require_relative "scenes/game/fish"
require_relative "scenes/game/cp_circle"
require_relative "scenes/game/player"
require_relative "scene"
require_relative "scenes/opening/director"
require_relative "scenes/game/director"
require_relative "scenes/ending/director"
require_relative "scenes/bending/director"

#　ウィンドウサイズを固定
Window.width = 800
Window.height = 600

#一番初めにdirector.rbが読み込まれる場所、ここで一回のみしかinitializeメソッドが使われない
Scene.add(Opening::Director.new, :opening)
Scene.add(Game::Director.new, :game)
Scene.add(Ending::Director.new, :ending)
Scene.add(Bending::Director.new, :bending)

#始めにオープニング画面に遷移する
Scene.move_to :opening

Window.loop do 
	#break if Input.key_push?(K_ESCAPE)
	Scene.play
	#Scene.play_music
end