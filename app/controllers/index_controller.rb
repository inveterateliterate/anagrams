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

def valid_input(input)
	if !input.empty?
		input = input.strip
		if !input.empty?
			@anagrams = Word.where("text=?", input)
			if !@anagrams.empty?
				true
			else
				raise Exception.new("Oops! We can't find that word in our dictionary. If you think it's a valid word, please add it to the dictionary!")
			end
		else 
			raise Exception.new("Please enter a word")
		end
	else 
		raise Exception.new("Please enter a word")
	end
end