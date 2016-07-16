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
  
  it "shows a page with a word's text and it's letters following a get request to /words/:id" do
    get("/words/#{@word.id}")
    expect(last_response.body).to include("#{@word.text}", "#{@word.letters}")
  end
  
  it "has a link to a word's show page on the index view" do
    get("/words")
    expect(last_response.body).to include("/words/#{@word.id}")
  end  
end