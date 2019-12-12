require 'minitest/autorun'
require_relative 'motion_simulator'
require_relative 'system_energy_calculator'

class TestMotionSimulator < Minitest::Test
  def test_first_assertion
    result = test_input_object_1.simulate(step: 10)

    test_moon_position({ x: 2, y: 1, z: -3 }, result[0])
    test_moon_velocity({ x: -3, y: -2, z: 1 }, result[0])

    test_moon_position({ x: 1, y: -8, z: 0 }, result[1])
    test_moon_velocity({ x: -1, y: 1, z: 3 }, result[1])

    test_moon_position({ x: 3, y: -6, z: 1 }, result[2])
    test_moon_velocity({ x: 3, y: 2, z: -3 }, result[2])

    test_moon_position({ x: 2, y: 0, z: 4 }, result[3])
    test_moon_velocity({ x: 1, y: -1, z: -1 }, result[3])

    test_system_energy(179, result)
  end

  def test_second_assertion
    result = test_input_object_2.simulate(step: 100)

    test_moon_position({ x:  8, y:-12, z: -9 }, result[0])
    test_moon_velocity({ x: -7, y:  3, z:  0 }, result[0])

    test_moon_position({ x: 13, y: 16, z: -3 }, result[1])
    test_moon_velocity({ x:  3, y:-11, z: -5 }, result[1])

    test_moon_position({ x:-29, y:-11, z: -1 }, result[2])
    test_moon_velocity({ x: -3, y:  7, z:  4 }, result[2])

    test_moon_position({ x: 16, y:-13, z: 23 }, result[3])
    test_moon_velocity({ x:  7, y:  1, z:  1 }, result[3])

    test_system_energy(1940, result)
  end

  private

  def test_input_object_1
    MotionSimulator.new('test_input_1.txt')
  end

  def test_input_object_2
    MotionSimulator.new('test_input_2.txt')
  end

  def test_moon_velocity(expected_velocity, moon)
    x_velocity_matches_value(expected_velocity[:x], moon)
    y_velocity_matches_value(expected_velocity[:y], moon)
    z_velocity_matches_value(expected_velocity[:z], moon)
  end

  def test_moon_position(expected_position, moon)
    x_position_matches_value(expected_position[:x], moon)
    y_position_matches_value(expected_position[:y], moon)
    z_position_matches_value(expected_position[:z], moon)
  end

  def x_position_matches_value(value, object)
    assert_equal(value, object.position.x)
  end

  def y_position_matches_value(value, object)
    assert_equal(value, object.position.y)
  end

  def z_position_matches_value(value, object)
    assert_equal(value, object.position.z)
  end

  def x_velocity_matches_value(value, object)
    assert_equal(value, object.velocity.x)
  end

  def y_velocity_matches_value(value, object)
    assert_equal(value, object.velocity.y)
  end

  def z_velocity_matches_value(value, object)
    assert_equal(value, object.velocity.z)
  end

  def test_system_energy(expected_energy, moons_list)
    assert_equal(
      expected_energy,
      SystemEnergyCalculator.new(moons_list).call
    )
  end
end
