module Ending
  class Director
    attr_accessor :score

    def initialize
        @font = Font.new(70)
        @result_img = Image.load('images/resultscreen.png')
    end

    def play(score)

        Window.draw(0, 0, @result_img)
        Window.draw_font(90, 250, "今回のスコアは#{score}です", @font, {color: [0,0,0]})
        scene_transition
    end

    private
    def scene_transition
        Scene.move_to(:opening) if Input.key_down?(K_ESCAPE)
    end    
  end
end
