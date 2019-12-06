require 'minitest/autorun'
require_relative 'orbits_count'

class TestOrbitsCount < Minitest::Test
  def test_calc_orbits
    assert_equal(
      42,
      calc_orbits('test_input.txt')
    )

    assert_equal(
      314247,
      calc_orbits('input.txt')
    )
  end

  def test_calc_orbital_transfers
    assert_equal(
      4,
      calc_orbital_transfers('test_input_part_2.txt')
    )

    assert_equal(
      514,
      calc_orbital_transfers('input.txt')
    )
  end
end
