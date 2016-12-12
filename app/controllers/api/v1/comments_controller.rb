module Api
  module V1
    class CommentsController < ApplicationController
      load_and_authorize_resource :task
      load_and_authorize_resource :comment, through: :task, shallow: true
      respond_to :json

      def index
        respond_with @comments
      end

      def create
        respond_with :api, :v1, @task.comments.create(comment_params)
      end

      def destroy
        respond_with @comment.destroy
      end

      private

      def comment_params
        params.permit(:id, :message, :task_id)
      end
    end
  end
end