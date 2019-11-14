require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    # it "should validate presence of email" do
    #   expect(user1.valid?).to be true
    # end
    # it "should validate presence of password_digest" do
    #   expect(user1.valid?).to be false
    # end
    
    # Using 'shoulda-matchers' gem
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password_digest) }
  end
  
  describe 'associations' do 
    it { should have_many(:notes) }
  end
  
  #let(:user1) { User.new(email: 'user1@gmail.com', password_digest: 'password') }
  describe "class methods" do
    user1 = User.create(email: 'user3@gmail.com', password: 'password')
    
    describe "#is_password?" do
      it "should check if the password is correct" do
        expect(user1.is_password?('password')).to eq(true)
      end
    end
    
    describe "#reset_session_token!" do
      it "should reset the session token" do
        expect(user1.session_token).to_not eq(user1.reset_session_token!)
      end
    end

    describe "::find_by_credentials" do
      it "should return the user by using it's name and password" do
        expect(User.find_by_credentials('user3@gmail.com', 'password')).to eq(user1)
      end
    end
  
  end
  
end
