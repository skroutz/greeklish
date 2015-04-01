require "greeklish/version"
require "greeklish/greeklish_generator"
require "greeklish/greek_reverse_stemmer"
require "greeklish/greeklish_converter"

module Greeklish
  def self.converter(options={})
    GreeklishConverter.new(options[:max_expansions],
                           options[:generate_greek_variants])
  end
end
