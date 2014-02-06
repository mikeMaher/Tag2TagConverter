require 'pry'
require 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require_relative 'converter'

class TagMappingTests < Minitest::Test

  def setup_and_exercise doc, tagmap
    converter = Converter.new(doc, tagmap)
    converter.run
  end

  def test_basic 
    input = '<foo><p>some text</p><pf/></foo>'
    map = {
      'p' => 'regular',
      'foo' => 'dingus',

    }
    output_doc = setup_and_exercise input, map
    assert output_doc.at_css('regular'), "'regular' is not there!"
    assert output_doc.at_css('pf'), "'pf' is gone!"
  end




end
