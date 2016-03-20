require "crsfml"
require "./game_object"

class EnemyDestroyer < GameObject
  def initialize(@scene)
    super(@scene)

    @rect = SF.float_rect(0, @scene.height + 100, @scene.width, 30)
  end

  def bounds
    @rect
  end

  def collides?(other_rect)
    bounds.intersects(other_rect)
  end

  def on_collide_with(plane : Plane)
    plane.destroy if plane.is_enemy
  end
end
