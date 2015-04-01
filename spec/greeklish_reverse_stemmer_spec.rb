# coding: utf-8
require 'spec_helper'

describe 'GreeklishReverseStemmer' do
  # Some greek words whose variations we want to produce.
  greek_words = ["κουρεματοσ", "ενδυματα", "γραφειου", "πεδιου",
                 "γραναζι", "ποδηλατα", "καλωδιων"]

  # Words that should not match to any rule.
  non_matching_words = ["σουτιεν", "κολλαν", "αμπαλαζ", "μακιγιαζ"]

  # The output we expect for each of the above words.
  greek_variants = [
    ["κουρεμα", "κουρεματων", "κουρεματα"],
    ["ενδυμα", "ενδυματων", "ενδυματα", "ενδυματοσ"],
    ["γραφειο", "γραφεια", "γραφειων"],
    ["πεδια", "πεδιο", "πεδιων"],
    ["γραναζια", "γραναζιου", "γραναζιων"],
    ["ποδηλατο", "ποδηλατου", "ποδηλατα", "ποδηλατων"],
    ["καλωδιου", "καλωδια", "καλωδιο"]
  ]

  before(:all) do
    @reverse_stemmer = Greeklish::GreekReverseStemmer.new
  end

  it "produces greek variants" do
    greek_words.each_with_index do |word, index|
      generated_greek_variants = @reverse_stemmer.generate_greek_variants(word)

      expect(generated_greek_variants.size > 1).to eq(true)

      greek_variants[index].each do |greek_variant|
        expect(generated_greek_variants.include?(greek_variant)).to eq(true)
      end
    end
  end

  it "does not produce variants for non matching words" do
    non_matching_words.each do |non_matching_word|
      generated_greek_variants = @reverse_stemmer.generate_greek_variants(non_matching_word)

      expect(generated_greek_variants.size).to eq(1)
    end
  end
end
