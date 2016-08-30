module Api
  module V1
    class AttachmentsController < ApplicationController
      load_and_authorize_resource :comment
      load_and_authorize_resource :attachment, through: :comment, shallow: true
      respond_to :json

      def create
        respond_with :api, :v1, @comment.attachments.create(attachment_params)
      end

      private

      def attachment_params
        params.permit(:file, :comment_id)
      end
    end
  end
end