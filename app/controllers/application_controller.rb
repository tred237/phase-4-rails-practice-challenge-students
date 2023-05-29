class ApplicationController < ActionController::API
    def record_not_found_error_message(invalid)
        render json: {"error": "#{invalid.message.split(" ")[2]} not found"}, status: :not_found
    end

    def unprocessable_entity_error_message(invalid)
        render json: {"errors": invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
