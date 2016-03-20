require "crsfml"
require "./game_object"
require "./events/enemy_killed"

class Plane < GameObject
  property is_enemy
  property health

  def initialize(@scene, @name : String, @gun : Gun, @is_enemy = false)
    super(@scene)
    @gun.position = position
    @health = 10

    @texture = SF::Texture.from_file("textures/planes/#{@name}.png")
    @sprite = SF::Sprite.new(@texture)
    @sprite.origin = @texture.size / 2

    @rect_shape = SF::RectangleShape.new(SF.vector2(230, 29))
    @rect_shape.origin = @texture.size / 2
  end

  def position=(new_position)
    super(new_position)
    @gun.position = new_position
  end

  def name=(@name : String)
    create_sprite
  end

  def start_shooting
    @gun.start_shooting
  end

  def stop_shooting
    @gun.stop_shooting
  end

  def destroy
    @health = 0
  end

  def alive?
    @health > 0
  end

  def get_damage(damage)
    @health -= damage
  end

  def bounds
    transform.translate(0, 20).transform_rect @rect_shape.global_bounds
  end

  def collides?(other_rect)
    bounds.intersects(other_rect)
  end

  def draw(window)
    @sprite.draw(window, SF.render_states(transform: transform))
  end

  def on_remove
    scene.remove_object @gun
  end

  def on_collide_with(bullet : Bullet)
    return if @gun.has_bullet?(bullet)

    get_damage bullet.damage

    if @is_enemy && !alive?
      scene.dispatch_event EnemyKilledEvent.new(self)
    end
  end

  def on_collide_with(plane : Plane)
    crash = !(plane.is_enemy && @is_enemy)
    @health = 0
  end
end
