require "./game_object"
require "./bullet"

class Gun < GameObject
  MAX_BULLETS = 20

  @bullets = [] of Bullet
  @last_shot = 0
  @bullet_per_second = 10

  @bullet_offset = SF.vector2(16, -57)
  @is_shooting = false

  property hit_delegate

  def initialize(@scene, @is_enemy = false, )
    super(@scene)
    @hit_delegate = nil
    @delay = 1.0 / @bullet_per_second
  end

  def has_bullet?(bullet)
    @bullets.includes?(bullet)
  end

  def start_shooting
    @is_shooting = true
  end

  def stop_shooting
    @is_shooting = false
  end

  def shot
    emit
  end

  private def emit
    @last_shot = 0

    bullet1 = Bullet.new(@scene, @hit_delegate, SF.vector2(0, -2000), "basic", @is_enemy)
    bullet1.position = position + SF.vector2(-20, -30)

    bullet2 = Bullet.new(@scene, @hit_delegate, SF.vector2(0, -2000), "basic", @is_enemy)
    bullet2.position = position + SF.vector2(20, -30)

    @bullets << bullet1
    @bullets << bullet2
  end

  def update(elapsed)
    @last_shot += elapsed

    enough_available_bullets = @bullets.size < MAX_BULLETS - 2
    enough_time_passed = @last_shot >= @delay

    if enough_available_bullets && enough_time_passed && @is_shooting
      emit
    end

    @bullets.reject! do |bullet|
      bullet.move(bullet.velocity * elapsed)
      if bullet.is_dead
        scene.remove_object bullet
        true
      else
        false
      end
    end
  end
end
