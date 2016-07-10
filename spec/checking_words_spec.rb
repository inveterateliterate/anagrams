require 'spec_helper'

describe 'Our Anagrams App' do
  include SpecHelper
  
  it 'does not include combinations which are not words when posting to /' do
    post("/", { word: 'cat' })
    expect(last_response.body).not_to include("cta", "atc", "tca", "tac")
  end
  
  it 'does not include combinations which are not words following a get request to /anagrams/:word' do
    get("/anagrams/cat")
    expect(last_response.body).not_to include("cta", "atc", "tca", "tac")
  end  
end