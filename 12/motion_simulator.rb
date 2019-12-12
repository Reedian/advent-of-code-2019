require_relative 'file_reader'
require_relative 'moon'
require 'byebug'

class MotionSimulator
  class PeriodCounter
    attr_reader :x_counter, :y_counter, :z_counter

    def initialize(moons_list)
      @initial_list = moons_list.map(&:dup)
      @x_counter = 1
      @y_counter = 1
      @z_counter = 1
      @x_satisfied = false
      @y_satisfied = false
      @z_satisfied = false
    end

    def increment(moon_list)
      self.x_counter += 1 unless x_satisfied?(moon_list)
      self.y_counter += 1 unless y_satisfied?(moon_list)
      self.z_counter += 1 unless z_satisfied?(moon_list)
    end

    def satisfied?
      x_satisfied && y_satisfied && z_satisfied
    end

    private

    attr_reader :initial_list
    attr_writer :x_counter, :y_counter, :z_counter
    attr_accessor :x_satisfied, :y_satisfied, :z_satisfied

    def x_satisfied?(moon_list)
      return true if x_satisfied
      self.x_satisfied = initial_list.map(&extract_x_axis) == moon_list.map(&extract_x_axis)
    end

    def y_satisfied?(moon_list)
      return true if y_satisfied
      self.y_satisfied = initial_list.map(&extract_y_axis) == moon_list.map(&extract_y_axis)
    end

    def z_satisfied?(moon_list)
      return true if z_satisfied
      self.z_satisfied = initial_list.map(&extract_z_axis) == moon_list.map(&extract_z_axis)
    end

    def extract_x_axis
      -> (moon) { [moon.position.x, moon.velocity.x] }
    end

    def extract_y_axis
      -> (moon) { [moon.position.y, moon.velocity.y] }
    end

    def extract_z_axis
      -> (moon) { [moon.position.z, moon.velocity.z] }
    end
  end

  def initialize(filename)
    input_file = FileReader.new(filename).call
    @moons_list = input_file.scan(/\<(.*?)\>/).flatten.map { |e|  Moon.new(e.scan(/-?\d+/)) }
  end

  def simulate(step:)
    step.times { simulate_move }
    moons_list
  end

  def calculate_period
    counter = PeriodCounter.new(moons_list)

    loop do
      simulate_move
      counter.increment(moons_list)
      break if counter.satisfied?
    end

    counter.x_counter.lcm(counter.y_counter.lcm(counter.z_counter))
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
