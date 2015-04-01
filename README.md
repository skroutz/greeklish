# Greeklish

Generate greeklish forms from Greek words.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'greeklish'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install greeklish

## Usage

Obtain an instance of `GreeklishConverter` as follows:

```ruby
converter = Greeklish.converter(max_expansions: 2,
                                generate_greek_variants: false)

greeklish_words = converter.convert('ομπρελα') # => ["omprela", "obrela"]

```

The option `max_expansions` denotes the maximum greeklish expansions for
each greek word, i.e:

```ruby
converter = Greeklish.converter(max_expansions: 4,
                                generate_greek_variants: false)

converter.convert('αυτοκινητο') # =>
    ["autokinhto", "aftokinhto", "avtokinhto", "aytokinhto"]
```

The option `generate_greek_variants` denotes if greek variants should
be generated, i.e:

```ruby
converter = Greeklish.converter(max_expansions: 2,
                                generate_greek_variants: true)

converter.convert('αμαξι') # =>
    ["amaksi", "amaxi", "amaksiou", "amaxiou", "amaksia", "amaxia",
     "amaksiwn", "amaxiwn"]
```

## Credits

Based on: [elasticsearch-analysis-greeklish](https://github.com/skroutz/elasticsearch-analysis-greeklish)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/greeklish/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
