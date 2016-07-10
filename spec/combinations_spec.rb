require 'spec_helper'

describe 'Our Anagrams App' do
  include SpecHelper
  
  it 'responds with a redirect on a post to /' do
    post("/", { word: 'cat' })
    expect(last_response.redirect?).to be(true)
  end
  
  it 'displays combinations for a word on a get to /anagrams/:word' do
    get("/anagrams/cat")
    expect(last_response.body).to include("cat", "cta", "act", "atc", "tca", "tac")
  end  
end