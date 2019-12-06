require 'minitest/autorun'
require_relative 'orbits_count'

class TestOrbitsCount < Minitest::Test
  def test_total_direct_and_indirect_orbits
    assert_equal(
      42,
      calc_orbits('test_input.txt')
    )

    assert_equal(
      314247,
      calc_orbits('input.txt')
    )
  end
end
