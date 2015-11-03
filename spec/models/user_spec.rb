require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = build(:user)
  end

  it "cannot be created without username" do
    @user.username = nil
    expect(@user.save).to be(false)
  end

  it "cannot be created without email" do
    @user.email = nil
    expect(@user.save).to be(false)
  end

  it "cannot be created without password" do
    @user.password = nil
    expect(@user.save).to be(false)
  end

  it "Two users cannot have same username" do
    second_user = @user.dup
    second_user.email = "another@email.com"
    @user.save
    expect(second_user.save).to be(false)
  end

  it "Two users cannot have same email" do
    second_user = @user.dup
    second_user.username = "test2"
    @user.save
    expect(second_user.save).to be(false)
  end

  it "email must have correct formatting" do
    @user.email = "ho@@la que ase@email malo . com "
    expect(@user.save).to be(false)
  end

  it "can be created with email, password and username" do
    user = User.new(email: "user@email.com", password: "12345678", username: "test1")

    expect(@user.save).to be(true)
  end

  context "password" do
    it "cannot be smaller than 8 chars" do
      @user.password = "1234567"
      expect(@user.save).to be(false)
    end
  end

  it "can edit his profile data" do
    params= { username: "paquito" }
    expect(@user.update_attributes(params)).to be(true)
  end
end
