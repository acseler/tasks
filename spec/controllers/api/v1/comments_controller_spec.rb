require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do

  before do
    sign_in_as_user
    apply_ability
  end

  let(:user) { FactoryGirl.create(:confirmed_user) }
  let(:project) { user.projects.last }
  let!(:task) { FactoryGirl.create(:task, project: project) }
  let!(:comment) { task.comments.last }
  let(:comment_attr) { FactoryGirl.attributes_for(:comment) }

  context 'GET#index' do
    it 'returns success response on get index' do
      comment_ability
      get :index, format: :json, params: { task_id: task }
      expect(response).to be_success
    end

    it_behaves_like 'user not authorized' do
      let(:action) { get :index, format: :json, params: { task_id: task } }
    end
  end

  context 'POST#create' do

    it_behaves_like 'user not authorized' do
      let(:action) { post :create, format: :json,
                          params: { task_id: task,
                                    message: comment_attr[:message] } }
    end

    it 'creates new task for project' do
      comment_ability
      expect{ post :create, format: :json,
                   params: { task_id: task,
                             message: comment_attr[:message] } }
          .to change(Comment, :count).by(1)
    end
  end

  context 'DELETE#destroy' do
    it_behaves_like 'user not authorized' do
      let(:action) { delete :destroy, format: :json, params: { id: comment } }
    end

    it 'deletes task' do
      comment_ability
      expect{ delete :destroy, format: :json, params: { id: comment } }
          .to change(Comment, :count).by(-1)
    end
  end
end