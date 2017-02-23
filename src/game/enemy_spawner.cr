require "crsfml"
require "./game_object"
require "./plane"
require "./enemy_controller"

class EnemySpawner < GameObject
  PLANE_NAMES = [
    "BF-109E",
    "Hawker"
  ]

  def initialize(@scene, @enemy_per_second = 1)
    super(@scene)
    @last_spawn = 0
    @delay = 1 / @enemy_per_second
  end

  def update(elapsed)
    @last_spawn += elapsed

    if @last_spawn > @delay
      spawn_enemy
      @last_spawn = 0
    end
  end

  def spawn_enemy
    enemy_controller = EnemyController.new(@scene, PLANE_NAMES.sample)
    enemy_controller.position = self.position + SF.vector2(Random.rand(scene.width), 250)
  end
end
