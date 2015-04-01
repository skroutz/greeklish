# coding: utf-8
require 'spec_helper'

describe 'Greeklish' do
  it "correctly converts to greeklish" do
    converter = Greeklish.converter(max_expansions: 10,
                                    generate_greek_variants: true)

    words = converter.convert("ομπρελα")

    expect(words).to include("omprela", "obrela")
  end
end
