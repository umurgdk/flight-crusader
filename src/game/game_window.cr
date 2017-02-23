class GameWindow
  def initialize(@width, @height, @title = "Game", @vsync = true)
    @window = SF::RenderWindow.new(SF.video_mode(@width, @height), @title)
    @window.vertical_sync_enabled = @vsync
    #@window.framerate_limit = 5
    @window.mouse_cursor_visible = false
  end

  forward_missing_to @window
end
