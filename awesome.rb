require 'pry'

def some_method(string)
  reverse_words = []
  words_array = string.split("\s")
  binding.pry
  words_array.each do |word|
    reverse_words << word.reverse
    binding.pry
  end
  reverse_words
end

some_method('This is a sentence with a lot of words')
