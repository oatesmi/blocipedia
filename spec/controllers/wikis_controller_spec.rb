require 'rails_helper'
include RandomData

RSpec.describe WikisController, type: :controller do
let(:user) { create(:user) }
let(:wiki) { create(:wiki, user: user) }

# before do
#   sign_in wiki.user
# end

  context "logged out" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #index view" do
        get :index
        expect(response).to render_template :index
      end

      it "assigns wiki to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([wiki])
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: wiki.id }
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        get :show, params: { id: wiki.id }
        expect(assigns(:wiki)).to eq(wiki)
      end
    end

    describe "GET #new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "POST #create" do
      it "returns http redirect" do
        post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "GET #edit" do
      it "returns http redirect" do
        get :edit, params: { id: wiki.id }
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "PUT #update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: { id: wiki.id, wiki: { title: new_title, body: new_body } }

        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "GET #destroy" do
      it "returns http redirect" do
        delete :destroy, params: { id: wiki.id }
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

  context "standard user" do
    before do
      user.standard!
      sign_in wiki.user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #index view" do
        get :index
        expect(response).to render_template :index
      end

      it "assigns wiki to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([wiki])
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: wiki.id }
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        get :show, params: { id: wiki.id }
        expect(assigns(:wiki)).to eq(wiki)
      end
    end

    describe "GET #new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "POST #create" do
      it "returns http redirect" do
        post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "GET #edit" do
      it "returns http redirect" do
        get :edit, params: { id: wiki.id }
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "PUT #update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: { id: wiki.id, wiki: { title: new_title, body: new_body } }

        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "GET #destroy" do
      it "returns http redirect" do
        delete :destroy, params: { id: wiki.id }
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

  context "premium user" do
    before do
      user.premium!
      sign_in wiki.user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #index view" do
        get :index
        expect(response).to render_template :index
      end

      it "assigns wiki to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([wiki])
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: wiki.id }
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        get :show, params: { id: wiki.id }
        expect(assigns(:wiki)).to eq(wiki)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST #create" do
      it "increases the number of wikis by 1" do
        expect{ post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: { id: wiki.id }
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, params: { id: wiki.id }
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq wiki.id
        expect(wiki_instance.title).to eq wiki.title
        expect(wiki_instance.body).to eq wiki.body
      end
    end

    describe "PUT #update" do
      it "updates wiki with expected attribtes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: { id: wiki.id, wiki: { title: new_title, body: new_body } }

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: { id: wiki.id, wiki: { title: new_title, body: new_body } }
        expect(response).to redirect_to wiki
      end
    end

    describe "GET #destroy" do
      it "returns http redirect" do
        delete :destroy, params: { id: wiki.id }
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

  context "admin user" do
    before do
      user.admin!
      sign_in wiki.user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #index view" do
        get :index
        expect(response).to render_template :index
      end

      it "assigns wiki to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([wiki])
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: wiki.id }
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        get :show, params: { id: wiki.id }
        expect(assigns(:wiki)).to eq(wiki)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST #create" do
      it "increases the number of wikis by 1" do
        expect{ post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: { id: wiki.id }
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, params: { id: wiki.id }
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq wiki.id
        expect(wiki_instance.title).to eq wiki.title
        expect(wiki_instance.body).to eq wiki.body
      end
    end

    describe "PUT #update" do
      it "updates wiki with expected attribtes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: { id: wiki.id, wiki: { title: new_title, body: new_body } }

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: { id: wiki.id, wiki: { title: new_title, body: new_body } }
        expect(response).to redirect_to wiki
      end
    end

    describe "GET #destroy" do
      it "deletes the wiki" do
        delete :destroy, params: { id: wiki.id }
        count = Wiki.where({id: wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to the wiki index" do
        delete :destroy, params: { id: wiki.id }
        expect(response).to redirect_to wikis_path
      end
    end
  end
end
