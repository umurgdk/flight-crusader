require "crsfml"
require "./scene"

class GameObject
  include SF::TransformableM

  property scene : Scene

  def initialize(@scene)
    @scene.add_object self
  end

  def draw(window)
  end

  def update(elapsed)
  end

  def dispatch_event(event : SF::Event)
    case event.type
    when SF::Event::MouseMoved
      on_mousemove(event.mouse_move)
    when SF::Event::KeyPressed
      on_keydown(event.key)
    when SF::Event::KeyReleased
      on_keyup(event.key)
    else
    end
  end

  def dispatch_event(event)
    on_event(event)
  end

  def on_mousemove(event : SF::MouseMoveEvent)
  end

  def on_mousedown(event : SF::MouseButtonEvent)
  end

  def on_mouseup(event : SF::MouseButtonEvent)
  end

  def on_keydown(event : SF::KeyEvent)
  end

  def on_keyup(event : SF::KeyEvent)
  end

  def on_event(event)
  end

  def on_collide_with(other : GameObject)
  end

  def on_remove
  end

  def bounds
    @bounds ||= SF.float_rect(0,0,0,0)
  end

  def collides?(type)
    false
  end
end
