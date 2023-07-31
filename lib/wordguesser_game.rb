class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  attr_accessor :word, :guesses, :wrong_guesses

  def guess(letter)
    raise ArgumentError if letter.nil?

    letter.downcase!

    if letter.empty?
      raise ArgumentError
    elsif !letter.match?(/[a-zA-Z]/)
      raise ArgumentError
    elsif @word.include?(letter) and not @guesses.include?(letter)
      @guesses << letter
      return true
    elsif not @wrong_guesses.include?(letter) and not @word.include?(letter)
      @wrong_guesses << letter
      return true
    end
    return false
  end

  def word_with_guesses
    display = ""
    @word.each_char do |char|
      if @guesses.include?(char)
        display += char
      else
        display += '-'
      end
    end
    display
  end

  def check_win_or_lose
    if @word.chars.all? { |char| @guesses.include?(char) }
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
