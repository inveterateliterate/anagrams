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

  it 'deletes a word when a DELETE request is sent to /words/:id' do
    id = @word.id
    delete("/words/#{id}")
    expect(Word.exists?(id)).to be(false)
  end
  
end