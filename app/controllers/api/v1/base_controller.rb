module Api
  module V1
    class BaseController < ApplicationController
      private

      def render_success(data, status: :ok)
        render json: {
          data: data,
          meta: { api_version: "v1" },
          error: nil
        }, status: status
      end

      def render_error(code:, message:, status:)
        render json: {
          data: nil,
          meta: { api_version: "v1" },
          error: {
            code: code,
            message: message
          }
        }, status: status
      end
    end
  end
end
