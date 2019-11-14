require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user5){ User.create!(email: 'user5@gmail.com', password: 'password') }
  
  describe "GET #new" do
    it "renders the user's new template" do
      # this line simulates a "GET" request to the LinksController that hits 
      # the #new method, passing in `{link: {}}` as params.
      get :new

      # check to make sure that the response renders back the new template
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's email and password"do
        post :create, params: { user5: { email: 'user5@gmail.com', password: '' }}
        expect(flash.now[:errors]).to be_present
        expect(response).to render_template(:new)
      end  
    
      it "validates that the password is at least 6 characters long" do
        post :create, params: { user5: { email: 'user5@gmail.com', password: 'pass' }}
        expect(flash.now[:errors]).to be_present
        expect(response).to render_template(:new)
      end
    end

    context "with valid params" do
      it "redirects user to bands index on success" do
        post :create, params: { user5: { email: 'user5@gmail.com', password: 'password' }}
        expect(response).to render_template(bands_url)
      end
    end
    
  end

  describe "Get #show" do
    it "renders the user's show template" do
      get :show, params: { id: user5.id }
      expect(response).to render_template(:show)
    end
  end


end
