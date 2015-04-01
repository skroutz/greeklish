# coding: utf-8
module Greeklish
  # Generates singular/plural variants of a greek word based on a
  # combination of predefined rules.
  class GreekReverseStemmer

    # Constant variable that represents suffixes for pluralization
    # of greeklish tokens.
    SUFFIX_MATOS = "ματοσ"
    SUFFIX_MATA = "ματα"
    SUFFIX_MATWN = "ματων"
    SUFFIX_AS = "ασ"
    SUFFIX_EIA = "εια"
    SUFFIX_EIO = "ειο"
    SUFFIX_EIOY = "ειου"
    SUFFIX_EIWN = "ειων"
    SUFFIX_IOY = "ιου"
    SUFFIX_IA = "ια"
    SUFFIX_IWN = "ιων"
    SUFFIX_OS = "οσ"
    SUFFIX_OI = "οι"
    SUFFIX_EIS = "εισ"
    SUFFIX_ES = "εσ"
    SUFFIX_HS = "ησ"
    SUFFIX_WN = "ων"
    SUFFIX_OY = "ου"
    SUFFIX_O = "ο"
    SUFFIX_H = "η"
    SUFFIX_A = "α"
    SUFFIX_I = "ι"

    # The possible suffix strings.
    SUFFIX_STRINGS = [
      [SUFFIX_MATOS, "μα", "ματων", "ματα"],
      [SUFFIX_MATA, "μα", "ματων", "ματοσ"],
      [SUFFIX_MATWN, "μα", "ματα", "ματοσ"],
      [SUFFIX_AS, "α", "ων", "εσ"],
      [SUFFIX_EIA, "ειο", "ειων", "ειου", "ειασ"],
      [SUFFIX_EIO, "εια", "ειων", "ειου"],
      [SUFFIX_EIOY, "εια", "ειου", "ειο", "ειων"],
      [SUFFIX_EIWN, "εια", "ειου", "ειο", "ειασ"],
      [SUFFIX_IOY, "ι", "ια", "ιων", "ιο"],
      [SUFFIX_IA, "ιου", "ι", "ιων", "ιασ", "ιο"],
      [SUFFIX_IWN, "ιου", "ια", "ι", "ιο"],
      [SUFFIX_OS, "η", "ουσ", "ου", "οι", "ων"],
      [SUFFIX_OI, "οσ", "ου", "ων"],
      [SUFFIX_EIS, "η", "ησ", "εων"],
      [SUFFIX_ES, "η", "ασ", "ων", "ησ", "α"],
      [SUFFIX_HS, "ων", "εσ", "η", "εων"],
      [SUFFIX_WN, "οσ", "εσ", "α", "η", "ησ", "ου", "οι", "ο", "α"],
      [SUFFIX_OY, "ων", "α", "ο", "οσ"],
      [SUFFIX_O, "α", "ου", "εων", "ων"],
      [SUFFIX_H, "οσ", "ουσ", "εων", "εισ", "ησ", "ων"],
      [SUFFIX_A, "ο" , "ου", "ων", "ασ", "εσ"],
      [SUFFIX_I, "ιου", "ια", "ιων"]
    ]

    # This hash has as keys all the suffixes that we want to handle in order
    # to generate singular/plural greek words.
    attr_reader :suffixes

    # The greek word list
    attr_reader :greek_words

    def initialize
      @suffixes = {}
      @greek_words = []

      # populate suffixes
      SUFFIX_STRINGS.each do |suffix|
        key = suffix[0]
        val = suffix[1..suffix.length]
        @suffixes[key] = val
      end
    end

    # This method generates the greek variants of the greek token that
    # receives.
    #
    # @param token_string the greek word
    # @return a list of the generated greek word variations
    def generate_greek_variants(token_string)
      # clear the list from variations of the previous greek token
      @greek_words.clear

      # add the initial greek token in the greek words
      @greek_words << token_string

      # Find the first matching suffix and generate the variants
      # of this word.
      SUFFIX_STRINGS.each do |suffix|
        if (token_string.end_with?(suffix[0]))
          # Add to greek_words the tokens with the desired suffixes
          generate_more_greek_words(token_string, suffix[0])
          break
        end
      end

      greek_words
    end

    # Generates more greek words based on the suffix of the original
    # word.
    #
    # @param input_suffix the suffix that matched.
    def generate_more_greek_words(input_token, input_suffix)
      suffixes[input_suffix].each do |suffix|
        @greek_words << input_token.gsub(/#{input_suffix}$/, suffix)
      end
    end
  end
end
