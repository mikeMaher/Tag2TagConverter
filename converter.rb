require "nokogiri"

class Converter

  def initialize doc, tagmap
  	@doc = Nokogiri.XML doc
  	@tagmap = tagmap
	end

	def run
		@doc.traverse do |node|
			next unless node.element?
			next unless @tagmap.include? node.name
			node.name = @tagmap[node.name]
		end
		@doc
	end

end

xml_file = ARGV[0]
tagmap_file = ARGV[1]
tagmap = Hash.new

File.read(tagmap_file).each_line do |line|
	next if !!( line.match /^\s*$/ )
	key = line.gsub(/\s.*/, '')
	value = line.gsub(/^[a-z0-9]+\s+|\n/, '')
	tagmap[key] = value
end

xml = File.read(xml_file)

converter = Converter.new(xml, tagmap)
output = converter.run.to_s

output_file = File.open( "output.xml", 'w')
output_file.write output
