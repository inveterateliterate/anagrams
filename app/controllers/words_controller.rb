get "/dictionary/new" do
@word = Word.new
erb :"/dictionary/new"
end

post "/dictionary" do
begin
	valid_entry(params[:word])
	lower = (params[:word])
	lower.downcase!
	@word = Word.create(text: lower)
	redirect "/dictionary/#{@word.id}"
rescue Exception => error	
	@error = error.message
	@word = Word.new
	#flash.now[:error] = error.message
	#redirect "/dictionary/new"	
	erb :"/dictionary/new"
end
end


get "/dictionary/:id/edit" do
	@word = Word.find(params[:id])
	erb :"/dictionary/edit"
end

put "/dictionary/:id" do
	@word = Word.find(params[:id])
	@word.text = params[:word]
begin
	valid_entry(@word.text)
	@word.save
	redirect "/dictionary/#{@word.id}"
rescue Exception => error
	@error = error.message
	@word = Word.find(params[:id])
	@word.text = params[:word]
	erb :"/dictionary/edit"
end
end

get "/dictionary/:id" do 
	@word = Word.find(params[:id])
erb :"/dictionary/show"
end

get "/dictionary" do
	@words = Word.all
	@words = @words.sort_by {|x| x.text}
erb :"/dictionary/index"
end

delete "/dictionary/:id" do
	word = Word.find(params[:id])
	word.delete
	redirect "/dictionary"
end

def avail_word?(input)
	@new_word = Word.where("text=?", input)
	if !@new_word.empty?
		true
	else
		false
	end
end

def valid_entry(input)
	if !input.empty?
		input = input.strip
		if !input.empty? 
			input.downcase!
			if !avail_word?(input) && input.match(/[0-9]/).nil?
				true
			elsif !input.match(/[0-9]/).nil?		
				raise Exception.new("Please enter words using letters only")
			elsif avail_word?(input)
				raise Exception.new("Oops, that word is already in our dictionary! Please enter a new word.")
			end	
		end
	else
		raise Exception.new("Please enter a word")	
	end
end
