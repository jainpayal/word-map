require "../model/word_map"
require "test/unit"

class WordMapTest < Test::Unit::TestCase
  test "should retrun empty array if number is invalid" do
    assert_equal([], WordMap.new.map_words(""))
    assert_equal([], WordMap.new.map_words("2"))
  end
  test "should retrun words" do
    assert_equal(7, WordMap.new.map_words("6686787825").length)
    assert_equal(8, WordMap.new.map_words("2282668687").length)
  end
end
