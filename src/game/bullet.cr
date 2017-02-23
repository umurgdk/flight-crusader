require "crsfml"
require "./game_object"

class Bullet < GameObject
  getter damage
  property velocity
  property is_dead

  def initialize(@scene, @hit_delegate, @velocity : SF::Vector2, @bullet_name : String, @is_enemy)
    super(@scene)
    @rect = SF.float_rect(0, 0, 10, 32)
    @sprite = SF::Sprite.new(SF::Texture.from_file("textures/bullets/#{@bullet_name}.png"))
    @damage = 1
    @is_dead = false
  end

  def bounds
    self.transform.transform_rect(@rect)
  end

  def enemy?
    @is_enemy
  end

  def damage
    1
  end

  def draw(window)
    @sprite.draw(window, SF.render_states(transform: transform))
  end

  def collides?(other_rect)
    bounds.intersects(other_rect)
  end

  def on_collide_with(object)
    return if object.is_a?(Bullet)

    if object.is_a?(Plane) && object.is_enemy == false
      return
    end

    if delegate = @hit_delegate
      if delegate.responds_to?(:on_hit)
        delegate.on_hit(object)
      end
    end
    @is_dead = true
  end
end
