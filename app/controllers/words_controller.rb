get "/words" do
	@words = Word.all
erb :"/words/index"
end