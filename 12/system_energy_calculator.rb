class SystemEnergyCalculator
  def initialize(moons_list)
    @moons_list = moons_list
  end

  def call
    moons_list.sum do |moon|
      position_energy = moon.position.x.abs + moon.position.y.abs + moon.position.z.abs
      velocity_energy = moon.velocity.x.abs + moon.velocity.y.abs + moon.velocity.z.abs

      position_energy * velocity_energy
    end
  end

  private

  attr_reader :moons_list
end
