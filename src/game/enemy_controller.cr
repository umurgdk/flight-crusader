require "crsfml"
require "./game_object"

class EnemyController < GameObject
  property plane
  property speed

  def initialize(@scene, plane_name, @speed = 500)
    super(@scene)

    gun = Gun.new(@scene, true)
    @plane = Plane.new(@scene, plane_name, gun, true)
    @plane.health = 10


    @collision_rects = SF.float_rect(-115, 10, 230, 29)

    @rect = SF::RectangleShape.new(SF.vector2(230, 29))
    @rect.position = SF.vector2(-115, 10)

    @plane.rotation = 180
    @plane.position = SF.vector2(0,0)
  end

  def position=(new_position)
    super(new_position)
    @plane.position = new_position
  end

  def update(elapsed)
    @plane.move(SF.vector2(0, @speed * elapsed))

    unless @plane.alive?
      scene.remove_object @plane
      scene.remove_object self
    end
  end
end
