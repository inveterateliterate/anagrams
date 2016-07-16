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

  it 'updates a word when a PUT request is sent to /words/:id' do
    id = @word.id
    put("/words/#{id}", { text: "skillcrusher" })
    expect(@word.reload.text == "skillcrusher").to be(true)
  end
  
end