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

  def children
    return [] unless direct_orbit
    [direct_orbit] + direct_orbit.children
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

  def find_by_name(name)
    list.detect { |orbit| orbit.name == name }
  end

  def_delegators :list, :sum
  def_delegators :list, :size
  def_delegators :list, :map
  def_delegators :list, :last
  #def_delegators :list, :index

  private

  attr_accessor :list

  def initialize_orbit(name)
    orbit = Orbit.new(name)
    list << orbit
    orbit
  end
end

def populate_orbit_list(input_file)
  orbit_list = OrbitList.new
  File.readlines(input_file).each do |line|
    a,b = line.strip.split(')')
    orbit_a = orbit_list.find_or_initialize_by_name(a)
    orbit_b = orbit_list.find_or_initialize_by_name(b)
    orbit_b.direct_orbit = orbit_a
  end
  orbit_list
end

def calc_orbits(input_file)
  orbit_list = populate_orbit_list(input_file)

  orbit_list.sum(&:connections_count)
end

def calc_orbital_transfers(input_file)
  orbit_list = populate_orbit_list(input_file)

  you = orbit_list.find_by_name('YOU')
  san = orbit_list.find_by_name('SAN')

  intersection_point = (you.children & san.children).first

  inter_you_index = you.children.index(intersection_point)
  inter_san_index = san.children.index(intersection_point)

  inter_san_index + inter_you_index
end
