

get "/words/new" do
@word = Word.new
erb :"/words/new"
end

post "/words" do
	@word = Word.create(text: params[:word])
	redirect "/words/#{@word.id}"
end


get "/words/:id/edit" do
	@word = Word.find(params[:id])
erb :"/words/edit"
end

put "/words/:id" do
	@word = Word.find(params[:id])
	@word.text = params[:word]

if @word.valid?
	@word.save
	redirect "/words/#{@word.id}"
else
	@word.errors.full_messages.each do |msg|
		@errors = "#{@errors} #{msg}."
	end
	erb :"/words/edit"
end
end

get "/words/:id" do 
	@word = Word.find(params[:id])
erb :"/words/show"
end

get "/words" do
	@words = Word.all.sort
erb :"/words/index"
end

delete "/words/:id" do
	word = Word.find(params[:id])
	word.delete
	redirect "/words"
end