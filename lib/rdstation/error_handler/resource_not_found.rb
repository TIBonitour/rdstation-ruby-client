module RDStation
  class ErrorHandler
    class ResourceNotFound
      attr_reader :api_response, :error

      ERROR_CODE = 'RESOURCE_NOT_FOUND'.freeze
      EXCEPTION_CLASS = RDStation::Error::ResourceNotFound

      def initialize(api_response)
        @api_response = api_response
        @error = JSON.parse(api_response.body)['errors']
      end

      def raise_error
        return unless resource_not_found?
        raise EXCEPTION_CLASS.new(error['error_message'], api_response)
      end

      private

      def resource_not_found?
        error['error_type'] == ERROR_CODE
      end
    end
  end
end
