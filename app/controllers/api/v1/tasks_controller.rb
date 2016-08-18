module Api
  module V1
    class TasksController < ApplicationController
      load_and_authorize_resource :project
      load_and_authorize_resource :task, through: :project, shallow: true
      respond_to :json

      def create
        respond_with :api, :v1, @project.tasks.create(task_params)
      end

      def index
        respond_with @tasks
      end

      private

      def task_params
        params.permit(:title, :completed, :project_id)
      end
    end
  end
end