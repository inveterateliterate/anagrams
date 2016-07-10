class Word < ActiveRecord::Base

def self.find_anagrams(string)

letters = string.split(//)
combinations= []

letters.each do |letter|
remaining = letters.select {|l| l !=letter}
combinations << letter + remaining.join("")
combinations << letter + reverse_letters(remaining).join("")
end

anagrams = []
combinations.each do |combo|
if Word.find_by_text(combo).present?
anagrams << combo
end
end
anagrams

end

def self.reverse_letters(letters)
length = letters.length
reversed_letters = Array.new(length)
letters.each_with_index do |letter,index|
reversed_letters[length-index-1] = letter
end

reversed_letters
end
end