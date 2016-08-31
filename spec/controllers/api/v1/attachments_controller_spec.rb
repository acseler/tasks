require 'rails_helper'

RSpec.describe Api::V1::AttachmentsController, type: :controller do

  before do
    sign_in_as_user
    apply_ability
  end

  let(:user) { FactoryGirl.create(:confirmed_user) }
  let(:project) { user.projects.last }
  let!(:task) { FactoryGirl.create(:task, project: project) }
  let!(:comment) { task.comments.last }
  let(:attach_attr) { FactoryGirl.attributes_for(:attachment) }

  context 'POST#create' do
    it_behaves_like 'user not authorized' do
      let(:action) { post :create, format: :json,
                          params: { comment_id: comment,
                                    file: attach_attr[:file] } }
    end

    it 'creates new task for project' do
      attachment_ability
      expect{ post :create, format: :json,
                   params: { comment_id: comment,
                             file: attach_attr[:file] } }
          .to change(Attachment, :count).by(1)
    end
  end
end