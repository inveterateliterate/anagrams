get "/dictionary/new" do
@word = Word.new
erb :"/dictionary/new"
end

post "/dictionary" do
begin
	valid_entry(params[:word])
	@word = Word.create(text: params[:word])
	redirect "/dictionary/#{@word.id}"
rescue Exception => error	
	#redirect "/dictionary/new"
	@error = error.message
	@word = Word.new
		
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
	valid_entry(params[:word])
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
	@words = Word.all.sort
erb :"/dictionary/index"
end

delete "/dictionary/:id" do
	word = Word.find(params[:id])
	word.delete
	redirect "/dictionary"
end

def valid_entry(input)
	if !input.empty?
		input = input.strip
		if !input.empty? && input.match(/[0-9]/).nil?
			true
		else
			raise Exception.new("Please enter words using letters only")
		end
	else
		raise Exception.new("Please enter a word")	
	end
end