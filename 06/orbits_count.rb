require 'forwardable'

class Orbit
  attr_accessor :direct_orbit
  attr_reader :name

  def initialize(name, direct_orbit=nil)
    @name = name
    @direct_orbit = direct_orbit
  end

  def connections_count
    return 0 unless direct_orbit
    1 + direct_orbit.connections_count
  end
end


class OrbitList
  extend Forwardable

  def initialize
    @list = []
  end

  def find_or_initialize_by_name(name)
    list.detect { |orbit| orbit.name == name } || initialize_orbit(name)
  end

  def_delegators :list, :sum
  def_delegators :list, :size
  def_delegators :list, :map

  private

  attr_accessor :list

  def initialize_orbit(name)
    orbit = Orbit.new(name)
    list << orbit
    orbit
  end
end

def calc_orbits(input_file)
  orbit_list = OrbitList.new
  File.readlines(input_file).each do |line|
    a,b = line.strip.split(')')
    orbit_a = orbit_list.find_or_initialize_by_name(a)
    orbit_b = orbit_list.find_or_initialize_by_name(b)
    orbit_b.direct_orbit = orbit_a
  end
  orbit_list.sum(&:connections_count)
end
