require 'spec_helper'

describe 'Our Anagrams App' do
  include SpecHelper
  
  before(:all) do
    @word = Word.create(text: "skillcrush")
  end
  
  after(:all) do
    word = Word.find_by_text("skillcrush")
    if word.present?
      word.delete
    end    
  end
  
  it 'shows an index page with words following a get request to /dictionary' do
    post("/dictionary", { text: "heroku" } )
    expect(Word.find_by_text("heroku").present?).to be(true)
  end  
  
  it "shows a page with a word's text and it's letters following a get request to /dictionary/:id" do
    get("/dictionary/#{@word.id}")
    expect(last_response.body).to include("#{@word.text}", "#{@word.letters}")
  end
  
  it "has a link to a word's show page on the index view" do
    get("/dictionary")
    expect(last_response.body).to include("/dictionary/#{@word.id}")
  end

  it 'shows an index page with words following a get request to /dictionary' do
    get("/dictionary")
    expect(last_response.body).to include("act", "cat")
  end  
end