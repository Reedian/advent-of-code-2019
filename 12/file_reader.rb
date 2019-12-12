class FileReader
  def initialize(filename)
    @filename = filename
  end

  def call
    File.read(filename)
  end

  private

  attr_reader :filename
end
