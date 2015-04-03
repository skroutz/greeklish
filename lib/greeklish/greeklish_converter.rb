# coding: utf-8
module Greeklish
  # Generates singular/plural variants of greek tokens and converts them
  # to tokens with latin characters from which are matched to the
  # corresponding greek characters. A Greek character may have one or more
  # latin counterparts. so, from a Greek token one or more latin tokens are
  # generated. Greek words have combination of vowels called digraphs. Because
  # digraphs are special cases, they are treated separately.
  class GreeklishConverter

    # Tokens that contain only these characters will be affected by this
    # filter.
    GREEK_CHARACTERS = "αβγδεζηθικλμνξοπρστυφχψω"

    # Keep the generated greek words from the greek reverse stemmer.
    attr_reader :greek_words

    # Input token converted into String.
    attr_reader :token_string

    # Instance of the reverse stemmer that generates the word variants
    # of the greek token.
    attr_reader :reverse_stemmer

    # Instance of the greeklish generator that generates the greeklish
    # words from the words that are returned by the greek reverse
    # stemmer.
    attr_reader :greeklish_generator

    # Setting which is set in the configuration file that defines
    # whether the user wants to generate greek variants.
    attr_reader :generate_greek_variants

    def initialize(max_expansions, generate_greek_variants)
      @greek_words = []
      @reverse_stemmer = GreekReverseStemmer.new
      @greeklish_generator = GreeklishGenerator.new(max_expansions)
      @generate_greek_variants = generate_greek_variants
    end

    # The actual conversion is happening here.
    #
    # @param input_token the Greek token
    # @param token_length the length of the input token
    # @return A list of the generated strings
    def convert(input_token)
      if (input_token[-1, 1] == "ς")
        input_token[-1, 1] = "σ"
      end

      # Is this a Greek word?
      if (!identify_greek_word(input_token))
        return nil
      end

      # if generating greek variants is on
      if (generate_greek_variants)
        # generate them
        @greek_words = reverse_stemmer.generate_greek_variants(input_token)
      else
        @greek_words << input_token
      end

      # if there are greek words
      if (greek_words.size > 0)
        # generate their greeklish version
        return greeklish_generator.generate_greeklish_words(greek_words)
      end

      nil
    end

    # Identifies words with only Greek lowercase characters.
    #
    # @param input The string that will examine
    # @return true if the string contains only Greek characters
    def identify_greek_word(input)
      input.each_char do |char|
        if (!GREEK_CHARACTERS.include?(char))
          return false
        end
      end

      true
    end
  end
end
