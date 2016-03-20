require "crsfml"
require "./plane"

class Player < GameObject
  @score = 0
  @health = 10

  getter gun : Gun
  getter scene : Scene
  getter score
  getter health

  def initialize(@scene : Scene)
    super(@scene)
    @gun = Gun.new(@scene)
    @plane = Plane.new(@scene, "B-17", @gun)
  end

  def on_start
    @gun.hit_delegate = self
  end

  def update(elapsed)
  end

  def on_mousemove(mouse)
    @plane.position = SF.vector2(mouse.x, mouse.y)
  end

  def on_keydown(key)
    @plane.start_shooting
  end

  def on_keyup(key)
    @plane.stop_shooting
  end

  def on_hit(target, bullet)
    if target.is_a?(Plane)
      unless target.alive?
        @score += 1
        scene.remove_object(target)
      end
    end
  end

  def on_event(event : EnemyKilledEvent)
    @score += 1
  end

  def on_event(event : PlayerKilledEvent)
    scene.change_to GameOverScene.new(self)
  end
end
