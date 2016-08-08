module Api
  module V1
    class ProjectsController < ApplicationController
      respond_to :json

      def index
        respond_with user_projects
      end

      def create
        respond_with :api, :v1, user_projects.create(project_params)
      end

      def update
        respond_with update_project(project_params)
      end

      def destroy
        respond_with user_projects.destroy(project_params[:id])
      end

      private

      def project_params
        params.permit(:id, :title)
      end

      def user_projects
        current_user.projects
      end

      def update_project(params)
        ProjectService.new(params).call
      end
    end
  end
end