require 'spec_helper'

describe 'Our Anagrams App' do
  include SpecHelper
  
  it 'valid_input throws an exception when input is more than 3 characters' do
    expect { valid_input("test") }.to raise_error
  end
  
  it 'valid_input throws an exception when input does not have distinct letters' do
    expect { valid_input("too") }.to raise_error
  end  
  
end