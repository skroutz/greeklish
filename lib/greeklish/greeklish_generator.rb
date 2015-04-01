# coding: utf-8
module Greeklish
  # Generates greeklish tokens that represent the character that
  # substitutes a digraph.
  class GreeklishGenerator

    # Constant variables that represent the character that substitutes
    # a digraph.
    AI = "Α"
    EI = "Ε"
    OI = "Ο"
    OY = "Υ"
    EY = "Φ"
    AY = "Β"
    MP = "Μ"
    GG = "Γ"
    GK = "Κ"
    NT = "Ν"

    # Each digraph is replaced by a special capital Greek character.
    attr_accessor :digraphs

    # This hash has keys all the possible conversions that can be applied
    # and values the strings that can replace the corresponding Greek
    # character.
    attr_accessor :conversions

    # The possible digraph cases.
    DIGRAPH_CASES = [
      ["αι", AI], ["ει", EI], ["οι", OI], ["ου", OY],
      ["ευ", EY], ["αυ", AY], ["μπ", MP], ["γγ", GG],
      ["γκ", GK], ["ντ", NT]
    ]

    # The possible string conversions for each case.
    CONVERT_STRINGS = [
      [AI, "ai", "e"], [EI, "ei", "i"], [OI, "oi", "i"],
      [OY, "ou", "oy", "u"], [EY, "eu", "ef", "ev", "ey"],
      [AY, "au", "af", "av", "ay"], [MP, "mp", "b"],
      [GG, "gg", "g"], [GK, "gk", "g"], [NT, "nt", "d"],
      ["α", "a"], ["β", "b", "v"], ["γ", "g"], ["δ", "d"],
      ["ε", "e"], ["ζ", "z"], ["η", "h", "i"], ["θ", "th"],
      ["ι", "i"], ["κ", "k"], ["λ", "l"], ["μ", "m"],
      ["ν", "n"], ["ξ", "ks", "x"], ["ο", "o"], ["π", "p"],
      ["ρ", "r"], ["σ", "s"], ["τ", "t"], ["υ", "y", "u", "i"],
      ["φ", "f", "ph"], ["χ", "x", "h", "ch"], ["ψ", "ps"],
      ["ω", "w", "o", "v"]
    ]

    # The maximum greeklish expansions per greek token.
    attr_reader :max_expansions

    # A list of greeklish token per each greek word.
    attr_reader :per_word_greeklish

    # Keep the generated strings in a list. The populated
    # list is returned to the filter.
    attr_reader :greeklish_list

    # Input token converted into String.
    attr_reader :input_token

    # Input token converted into String without substitutions.
    attr_reader :initial_token

    attr_reader :words

    def initialize(max_expansions)
      @max_expansions = max_expansions
      @greeklish_list = []
      @per_word_greeklish = []
      @digraphs = {}
      @conversions = Hash.new([])

      # populate digraphs
      DIGRAPH_CASES.each do |digraph_case|
        key = digraph_case[0]
        value = digraph_case[1]
        @digraphs[key] = value
      end

      # populate conversions
      CONVERT_STRINGS.each do |convert_string|
        key = convert_string[0]
        value = convert_string[1..convert_string.length]
        @conversions[key] = value
      end
    end

    # Gets a list of greek words and generates the greeklish version of
    # each word.
    #
    # @param greek_words a list of greek words
    # @return a list of greeklish words
    def generate_greeklish_words(greek_words)
      @greeklish_list.clear

      greek_words.each do |greek_word|
        @per_word_greeklish.clear

        initial_token = greek_word

        # Allocate space that is twice the length of the input token
        # in order to cover worst case scenario where each Greek character
        # is replaced by two latin characters.
        allocated_space = 2 * greek_word.length

        digraphs.each_key do |key|
          greek_word = greek_word.gsub(key, digraphs[key])
        end

        # Convert it back to array of characters. The iterations of each
        # character will take place through this array.
        input_token = greek_word.split(//)

        # Iterate through the characters of the token and generate
        # greeklish words.
        input_token.each do |greek_char|
          add_character(conversions[greek_char], allocated_space)
        end

        @greeklish_list << per_word_greeklish.flatten
      end

      @greeklish_list.flatten
    end

    # Add the matching latin characters to the generated greeklish tokens
    # for a specific Greek character. For each different combination of
    # latin characters, a new token is generated.
    #
    # @param convert_strings the latin characters that will be added to the tokens
    # @param buffer_size The size of the buffer that will be allocated in case of
    #  new result.
    private

    def add_character(convert_strings, buffer_size)
      if (per_word_greeklish.empty?)
        convert_strings.each do |convert_string|
          if (per_word_greeklish.size >= max_expansions)
            break
          end
          @per_word_greeklish << convert_string
        end
      else
        new_tokens = []

        convert_strings.each do |convert_string|
          per_word_greeklish.each do |token|
            new_tokens << "#{token}#{convert_string}"
          end
          if (per_word_greeklish.size >= max_expansions)
            break
          end
        end

        @per_word_greeklish = new_tokens
      end
    end
  end
end
