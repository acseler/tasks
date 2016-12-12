require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do

  before do
    sign_in_as_user
    apply_ability
  end

  let(:user) { FactoryGirl.create(:confirmed_user) }
  let(:project) { user.projects.last }
  let!(:task) { FactoryGirl.create(:task, project: project) }
  let(:task_attr) { FactoryGirl.attributes_for(:task) }

  context 'GET#index' do
    it 'returns success response on get index' do
      task_ability
      get :index, format: :json, params: { project_id: project.id }, session: { user_id: user.id }
      expect(response).to be_success
    end

    it_behaves_like 'user not authorized' do
      let(:action) { get :index, format: :json, params: { project_id: project } }
    end
  end

  context 'POST#create' do

    it_behaves_like 'user not authorized' do
      let(:action) { post :create, format: :json,
                          params: { title: task_attr[:title],
                                    project_id: project } }
    end

    it 'creates new task for project' do
      task_ability
      expect{ post :create, format: :json, params: { title: task_attr[:title],
                                                    project_id: project } }
          .to change(Task, :count).by(1)
    end
  end

  context 'PUT#update' do
    it_behaves_like 'user not authorized' do
      let(:action) { put :update, format: :json,
                          params: { title: task_attr[:title],
                                    id: task } }
    end

    it 'updates task' do
      task_ability
      expect(Task.find_by(id: task.id).title).to eq task.title
      put :update, format: :json, params: { title: task_attr[:title], id: task }
      expect(Task.find_by(id: task.id).title).to eq task_attr[:title]

    end
  end

  context 'DELETE#destroy' do
    it_behaves_like 'user not authorized' do
      let(:action) { delete :destroy, format: :json, params: { id: task } }
    end

    it 'deletes task' do
      task_ability
      expect{ delete :destroy, format: :json, params: { id: task } }
          .to change(Task, :count).by(-1)
    end
  end
end
