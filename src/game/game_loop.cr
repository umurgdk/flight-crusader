class GameLoop
  property scene : Scene

  @elapsed = 0

  def initialize(@scene : Scene, @window : GameWindow)
    @clock = SF::Clock.new
  end

  def start
    while @window.open?
      @elapsed = @clock.restart.as_seconds

      @window.clear SF::Color::Black

      while event = @window.poll_event
        case event.type
        when SF::Event::Closed
          @window.close
        else
          scene.dispatch_event event
        end
      end

      scene.update @elapsed
      scene.check_collisions
      scene.draw @window

      @window.display
    end
  end
end
