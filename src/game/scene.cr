require "crsfml"
require "./game_object"

class Scene
  @objects = [] of GameObject

  getter objects
  getter width
  getter height

  def initialize(@width, @height)
  end

  def add_object(obj)
    @objects << obj
  end

  def remove_object(obj)
    obj.on_remove
    @objects.delete(obj)
  end

  def update(elapsed)
    @objects.each &.update(elapsed)
  end

  def draw(window)
    @objects.each &.draw(window)
  end

  def dispatch_event(event)
    @objects.each do |obj|
      obj.dispatch_event(event)
    end
  end

  def check_collisions
    @objects.each do |subject|
      @objects.each do |target|
        next if target == subject
        subject.on_collide_with(target) if subject.collides?(target.bounds)
      end
    end
  end
end
