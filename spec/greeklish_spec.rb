# coding: utf-8
require 'spec_helper'

describe 'Greeklish' do
  it "correctly converts to greeklish" do
    converter = Greeklish.converter(max_expansions: 2,
                                    generate_greek_variants: false)

    words = converter.convert("ομπρελα")

    expect(words.length).to eq(2)
    expect(words).to include("omprela", "obrela")
  end
end
