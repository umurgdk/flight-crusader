require "crsfml"
require "./game/*"

module FlightCrusader
  enum Layer
    Background
    Ground
    Obstacles
    Effects
  end

  window = GameWindow.new(1440, 1700)

  scene = Scene.new(1440, 1700)

  player = Player.new(scene)
  enemy_spawner = EnemySpawner.new(scene)
  enemy_destroyer = EnemyDestroyer.new(scene)
  bounds = OffScreenBounds.new(scene)
  hud = HUD.new(scene, player)

  game = GameLoop.new(scene, window)
  game.start
end
