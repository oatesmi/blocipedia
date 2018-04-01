require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let(:user) { create(:user) }

  context "when not logged in" do
    describe "GET #new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context "when logged in as a standard user" do
    before do
      user.standard!
      sign_in(user)
    end

    describe "GET #new" do
      it "returns http status of success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "assigns the stripe object to @stripe_btn_data" do
        get :new
        expect(assigns(:stripe_btn_data)).not_to be_nil
      end
    end
  end

  # context "when logged in as a premium user" do
  #   before do
  #     user.premium!
  #     sign_in(user)
  #   end
  #
  #   describe "GET #new" do
  #     it "returns http redirect" do
  #       get :new
  #       expect(response).to redirect_to(user_session_path)
  #     end
  #
  #     it "does not assign the stripe object to @stripe_btn_data" do
  #       get :new
  #       expect(assigns(:stripe_btn_data)).to be_nil
  #     end
  #   end
  # end
end
