require_relative 'motion_simulator'
require_relative 'system_energy_calculator'

puts SystemEnergyCalculator.new(
  MotionSimulator.new('input.txt').simulate(step: 1000)
).call
