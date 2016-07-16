get "/" do
erb :index
end

get "/anagrams/:word" do
@word = params[:word]
@alphabetized_string = @word.chars.sort.join
@anagrams = Word.where("letters=?", @alphabetized_string)
erb :show
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

def three_letters?(input)
if (input.length <= 3)
return true
else 
return false
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

def valid_input(input)
if three_letters?(input) && distinct_letters?(input)
true
else
	raise Exception.new("Oops! You should enter a word with three or fewer unique letters.")
end
end
