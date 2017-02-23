require "crsfml"
require "./game_object"

class HUD < GameObject
  def initialize(@scene, @player)
    super(@scene)
    @font = SF::Font.from_file("textures/hud.ttf")

    @score_text = SF::Text.new
    @score_text.font = @font
    @score_text.string = ""
    @score_text.character_size = 60
    @score_text.color = SF::Color::White

    @objects_text = SF::Text.new
    @objects_text.font = @font
    @objects_text.string = ""
    @objects_text.character_size = 30
    @objects_text.color = SF::Color::White
    @objects_text.position = SF.vector2(0, 80)
  end

  def update(elapsed)
    @score_text.string = "SCORE: #{@player.score}"
    @objects_text.string = "Objects: #{scene.objects.size}"
  end

  def draw(window)
    window.draw(@score_text)
    window.draw(@objects_text)
  end
end
