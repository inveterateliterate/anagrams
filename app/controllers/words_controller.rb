get "/words" do
	@words = Word.all
erb :"/words/index"
end

get "/words/:id" do
@id = params[:id]
@word = Word.find_by_id(@id)
erb :"/words/show"
end