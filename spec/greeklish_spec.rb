# coding: utf-8
require 'spec_helper'

describe 'Greeklish' do
  it "correctly converts to greeklish" do
    max_expansions = 10
    generate_greek_variants = false
    converter = Greeklish.converter(max_expansions: 10,
                                    generate_greek_variants: true)

    words = converter.convert("ομπρελα".split(//), 7)

    expect(words).to include("omprela", "obrela")
  end
end
