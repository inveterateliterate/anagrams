require 'spec_helper'

describe 'Our Anagrams App' do
  include SpecHelper
  
  it 'responds with a redirect on a post to /' do
    post("/", { word: 'cat' })
    expect(last_response.redirect?).to be(true)
  end
  
  it 'does not include combinations which are not words following a get request to /anagrams/:word' do
    get("/anagrams/cat")
    expect(last_response.body).not_to include("cta", "atc", "tca", "tac")
  end  
  
  it 'does include anagrams which are words following a get request to /anagrams/:word' do
    get("/anagrams/cat")
    expect(last_response.body).to include("act")
  end
  
  it 'should display an error if input is longer than 3 characters' do
    post("/", { word: 'catch' })
    expect(last_response.body).to include("<p class='error'>")
  end
  
  it 'should display an error if input is does not have distinct letters' do
    post("/", { word: 'too' })
    expect(last_response.body).to include("<p class='error'>")
  end  
end