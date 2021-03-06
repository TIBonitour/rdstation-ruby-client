module RDStation
  class ErrorHandler
    class InvalidCredentials
      attr_reader :api_response, :error

      ERROR_CODE = 'ACCESS_DENIED'.freeze
      EXCEPTION_CLASS = RDStation::Error::InvalidCredentials

      def initialize(api_response)
        @api_response = api_response
        @error = JSON.parse(api_response.body)['errors']
      end

      def raise_error
        return unless credentials_errors?
        raise EXCEPTION_CLASS.new(error['error_message'], api_response)
      end

      private

      def credentials_errors?
        error['error_type'] == ERROR_CODE
      end
    end
  end
end
