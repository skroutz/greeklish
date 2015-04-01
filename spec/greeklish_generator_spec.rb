# coding: utf-8
require 'spec_helper'

describe 'GreeklishGenerator' do
  max_expansions = 10

  # a sample of greek words to generate their greeklish
  # counterparts.
  greek_words = ["αυτοκινητο", "ομπρελα", "ξεσκεπαστοσ"]

  # the greeklish counterparts that should be generated
  # from the greek words.
  generated_greeklish_words = [
    "autokinhto", "aftokinhto", "avtokinhto", "aytokinhto",
    "autokinito", "aftokinito", "avtokinito", "aytokinito",
    "omprela", "obrela", "kseskepastos", "xeskepastos"
  ]

  before(:each) do
    @input_greek_list = []
    @greeklish_words = []
    @converted_greeklish_strings = []

    @generator = Greeklish::GreeklishGenerator.new(max_expansions)
    greek_words.each do |word|
      @input_greek_list << word
    end
  end

  after(:each) do
    @converted_greeklish_strings = []
  end

  it "converts valid words" do
    greek_words.each do |word|
      @greeklish_words = @generator.generate_greeklish_words(@input_greek_list)

      populate_converted_strings_list

      expect(@greeklish_words.empty?).to eq(false)

      generated_greeklish_words.each do |greeklish_word|
        expect(@converted_greeklish_strings.include?(greeklish_word)).to eq(true)
      end
    end
  end

  it "respects the max expansion setting" do
    @input_greek_list = []
    new_max_expansions = 2
    generator = Greeklish::GreeklishGenerator.new(new_max_expansions)

    greeklish_words = generator.generate_greeklish_words(@input_greek_list)
    expect(greeklish_words.size).to eq(new_max_expansions * @input_greek_list.size)
  end

  private

  def populate_converted_strings_list
    @greeklish_words.each do |word|
      @converted_greeklish_strings << word
    end
  end
end
