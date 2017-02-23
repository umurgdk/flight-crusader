require "crsfml"
require "./game_object"

class OffScreenBounds < GameObject
  def initialize(@scene : Scene)
    super(@scene)

    width = scene.width
    height = scene.height

    @top_rect = SF.float_rect(0, -20, width, 10)
    @bottom_rect = SF.float_rect(0, height + 10, width, 10)
    @right_rect = SF.float_rect(width + 10, 0, 10, height)
    @left_rect = SF.float_rect(-20, 0, 10, height)
    @rects = [@top_rect, @bottom_rect, @left_rect, @right_rect]
  end

  def collides?(other_rect)
    @rects.any? &.intersects(other_rect)
  end

  def on_collide_with(bullet : Bullet)
    bullet.is_dead = true
  end
end
