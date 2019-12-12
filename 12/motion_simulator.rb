require_relative 'file_reader'
require_relative 'moon'
require 'byebug'

class MotionSimulator
  def initialize(filename)
    input_file = FileReader.new(filename).call
    @moons_list = input_file.scan(/\<(.*?)\>/).flatten.map { |e|  Moon.new(e.scan(/-?\d+/)) }
  end

  def simulate(step:)
    step.times { simulate_move }
    moons_list
  end
  
  private

  attr_reader :moons_list

  def simulate_move
    moons_list.combination(2) { |moons_pair| apply_gravity(*moons_pair) }
    moons_list.each { |moon| moon.apply_velocity }
  end

  def apply_gravity(moon_a, moon_b)
    apply_x_gravity(moon_a, moon_b)
    apply_y_gravity(moon_a, moon_b)
    apply_z_gravity(moon_a, moon_b)
  end

  def apply_x_gravity(moon_a, moon_b)
    case moon_a.position.x <=> moon_b.position.x
    when 1
      moon_a.velocity.x -= 1
      moon_b.velocity.x += 1
    when -1
      moon_a.velocity.x += 1
      moon_b.velocity.x -= 1
    end
  end

  def apply_y_gravity(moon_a, moon_b)
    case moon_a.position.y <=> moon_b.position.y
    when 1
      moon_a.velocity.y -= 1
      moon_b.velocity.y += 1
    when -1
      moon_a.velocity.y += 1
      moon_b.velocity.y -= 1
    end
  end

  def apply_z_gravity(moon_a, moon_b)
    case moon_a.position.z <=> moon_b.position.z
    when 1
      moon_a.velocity.z -= 1
      moon_b.velocity.z += 1
    when -1
      moon_a.velocity.z += 1
      moon_b.velocity.z -= 1
    end
  end

  def present(list, step = 0)
    puts "After #{step} steps:"
    list.each do |moon|
      puts moon.to_s
    end
  end
end
