get "/" do
erb :index
end

get "/anagrams/:word" do
@word = params[:word]
@word.downcase!
@alphabetized_string = @word.chars.sort.join
@anagrams = Word.where("letters=?", @alphabetized_string)
if @anagrams.length > 1
	erb :show
else
	@no_anagram = "There do not appear to be any anagrams for this word.\nIf you think we've missed any, please add them to the dictionary!"
	erb :show
end
end

post "/" do
@word = params[:word]
begin
	valid_input(@word)
	redirect "/anagrams/#{@word}"
rescue Exception => error
	@error = error.message
	erb :index
end
end



def distinct_letters?(input)
	letter_array = input.chars
 	unique_letters = letter_array.uniq
 	if unique_letters.length < letter_array.length
 		false
 	else
 		true
 	end
end
 
def avail_word?(input)
			@anagrams = Word.where("text=?", input)
			if !@anagrams.empty?
				true
			else
				false
			end
end


def valid_input(input)
if !input.empty?
	input = input.strip
	if !input.empty?
		input.downcase!
		if avail_word?(input) && distinct_letters?(input)
 			true
		elsif !distinct_letters?(input)
			raise Exception.new("Oops! You should enter a word with unique letters.")
		elsif !avail_word?(input)
			raise Exception.new("Oops! We can't find that word in our dictionary. If you think it's a valid word, please add it to the dictionary!")
 		end
	else
		raise Exception.new("Please enter a word")
	end
else
	raise Exception.new("Please enter a word")
end
end