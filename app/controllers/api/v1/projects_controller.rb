module Api
  module V1
    class ProjectsController < ApplicationController
      load_and_authorize_resource
      respond_to :json

      def index
        respond_with @projects
      end

      def show
        respond_with @project
      end

      def create
        respond_with :api, :v1, user_projects.create(project_params)
      end

      def update
        respond_with @project.update(project_params)
      end

      def destroy
        respond_with @project.destroy
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