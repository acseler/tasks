require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

  before do
    sign_in_as_user
    apply_ability
  end

  let(:user) { FactoryGirl.create(:confirmed_user) }
  let(:project) { user.projects.last }

  context 'GET#index' do
    it 'returns success response on get index' do
      project_ability
      get :index, format: :json
      expect(response).to be_success
    end

    it_behaves_like 'user not authorized' do
      let(:action) { get :index, format: :json }
    end

    it 'assigns projects as @projects' do
      project_ability
      get :index, format: :json
      expect(assigns(:projects)).to match_array user.projects
    end
  end

  context 'GET#show' do
    it_behaves_like 'user not authorized' do
      let(:action) { get :show, format: :json, params: { id: project } }
    end

    it 'assigns project as @project' do
      project_ability
      get :show, format: :json, params: { id: project }
      expect(assigns(:project)).to eq project
    end
  end

  context 'POST#create' do
    it_behaves_like 'user not authorized' do
      let(:action) { post :create, format: :json, params: {title: 'New project' } }
    end

    it 'creates new project' do
      project_ability
      expect(user.projects.count).to eq 1
      expect{ post :create, format: :json, params: {title: 'New project' } }
        .to change(Project, :count).by(1)
    end
  end

  context 'PUT#update' do
    let(:project_attr) { FactoryGirl.attributes_for(:project, user: user) }
    it_behaves_like 'user not authorized' do
      let(:action) { put :update, format: :json,
                         params: { id: project, title: project_attr[:title] } }
    end

    it 'updates project' do
      project_ability
      put :update, format: :json,
          params: { id: project, title: project_attr[:title] }
      expect(Project.find_by(id: project.id).title).to eq project_attr[:title]
    end
  end

  context 'DELETE#destroy' do
    it_behaves_like 'user not authorized' do
      let(:action) { delete :destroy, format: :json, params: { id: project} }
    end
  end

  it 'deletes project' do
    project_ability
    expect{ delete :destroy, format: :json, params: { id: project } }
        .to change(Project, :count).by(-1)

  end
end
