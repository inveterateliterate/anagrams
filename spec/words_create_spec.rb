require 'spec_helper'

describe 'Our Anagrams App' do
  include SpecHelper
  
  after(:all) do
    word = Word.find_by_text("skillcrush")
    if word.present?
      word.delete
    end
  end
  
  it 'shows an index page with words following a get request to /words' do
    post("/words", { text: "skillcrush" } )
    expect(Word.find_by_text("skillcrush").present?).to be(true)
  end
end