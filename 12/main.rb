require_relative 'motion_simulator'
require_relative 'system_energy_calculator'

# Part 1
puts SystemEnergyCalculator.new(
  MotionSimulator.new('input.txt').simulate(step: 1000)
).call

# Part 2
puts MotionSimulator.new('input.txt').calculate_period
