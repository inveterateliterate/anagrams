require 'spec_helper'

describe 'Our Anagrams App' do
  include SpecHelper
  
  it 'shows an index page with words following a get request to /words' do
    get("/words")
    expect(last_response.body).to include("act", "cat")
  end
end