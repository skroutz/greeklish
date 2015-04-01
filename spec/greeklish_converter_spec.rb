# coding: utf-8
require 'spec_helper'

describe 'GreeklishConverter' do
  max_expansions = 10
  generate_greek_variants = true

  # a sample of greek words to generate their greeklish
  # counterparts.
  greek_words = ["αυτοκινητο", "ομπρελα", "ξεσκεπαστοσ"]

  # the greeklish counterparts that should be generated from the greek words.
  generated_greeklish_words = [
    ["autokinhto", "aftokinhto", "avtokinhto", "aytokinhto",
     "autokinito", "aftokinito", "avtokinito", "aytokinito",
     "autokinhtwn", "aftokinhta", "avtokinhta", "aytokinhtwn"],
    ["omprela", "obrela", "ompreles", "obrelwn", "obreles", "omprelas"],
    ["kseskepastos", "xeskepastos", "kseskepastou", "xeskepastwn", "kseskepastoi"]
  ]

  # these words should not be processed by the converter.
  invalid_words = ["mobile", "αυριο64", "καλάθι", "ΣΠιτι", "ομορφος" ]

  before(:each) do
    @greeklish_words = []
    @converted_greeklish_strings = []
  end

  after(:each) do
    @converted_greeklish_strings = []
    @greeklish_words = []
  end

  it "does not convert invalid words" do
    converter = Greeklish::GreeklishConverter.new(max_expansions, generate_greek_variants)

    invalid_words.each do |invalid_word|
      @greeklish_words = converter.convert(invalid_word.split(//), invalid_word.length)
      expect(@greeklish_words.nil?).to eq(true)
    end
  end

  it "converts valid words" do
    converter = Greeklish::GreeklishConverter.new(max_expansions, generate_greek_variants)

    greek_words.each_with_index do |word, i|
      @greeklish_words = converter.convert(greek_words[i].split(//),
                                          greek_words[i].length)
      populate_converted_strings_list

      expect(@greeklish_words.empty?).to eq(false)

      generated_greeklish_words[i].each do |greeklish_word|
        expect(@converted_greeklish_strings.include?(greeklish_word)).to eq(true)
      end
    end
  end

  it "respects max expansions" do
    new_max_expansions = 2
    generate_greek_variants = false
    converter = Greeklish::GreeklishConverter.new(new_max_expansions, generate_greek_variants)

    @greeklish_words = converter.convert(greek_words[0].split(//),
                                        greek_words[0].length)

    populate_converted_strings_list()

    expect(@greeklish_words.size).to eq(new_max_expansions)

    for i in 0..new_max_expansions-1 do
      expect(@converted_greeklish_strings.include?(generated_greeklish_words[0][i])).to eq(true)
    end

    for j in new_max_expansions..generated_greeklish_words[0].length - 1 do
      expect(@converted_greeklish_strings.include?(generated_greeklish_words[0][j])).to eq(false)
    end
  end

  it "respects variant generation" do
    new_max_expansions = 1
    generate_greek_variants = false
    converter = Greeklish::GreeklishConverter.new(new_max_expansions, generate_greek_variants)

    @greeklish_words = converter.convert(greek_words[0].split(//),
                                       greek_words[0].length)

    populate_converted_strings_list()

    expect(@converted_greeklish_strings.include?(generated_greeklish_words[0][0])).to eq(true)
    expect(@converted_greeklish_strings.include?(generated_greeklish_words[0][9])).to eq(false)
  end

  private

  def populate_converted_strings_list
    @greeklish_words.each do |word|
      @converted_greeklish_strings << word
    end
  end
end
