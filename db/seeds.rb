require "csv"

csv_text = File.read("db/dictionary.csv")
dictionary_words = CSV.parse(csv_text)
dictionary_words.each do |row|
	Word.create!(text: row[0])
end