require 'rails_helper'

RSpec.describe Post, type: :model do
  it "Cannot be instantiated directly" do
    expect { Post.new }.to raise_error RuntimeError,"Cannot directly instantiate a Post"
  end
end
