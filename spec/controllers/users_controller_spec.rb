require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  let(:user) { create(:user) }


  describe "GET #confirm_form" do

    before { get :confirm_form }

    it "assigns a new user to @user" do
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders confirm_form view" do
      expect(response).to render_template :confirm_form
    end
  end


  # describe "POST #confirmation" do
  #   post :confirmation
  #   user.reload
  # end
end
