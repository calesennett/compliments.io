class DigitsController < ApplicationController
  def create
    set_up_request
    perform_request
    format_response
    find_or_create_user

    render json: {succes: @user.save}
  end

  private

    def set_up_request
      @uri = URI.parse(params["apiUrl"])
    end

    def perform_request
      args = {
        'Authorization' => params["credentials"]
      }

      http         = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      req          = Net::HTTP::Get.new(@uri.request_uri, args)

      @response = JSON.parse(http.request(req).body)
    end

    def format_response
      @formatted_response = {
        phoneNumber: @response["phone_number"],
        userID: @response["id_str"],
        error: ''
      }
    end

    def find_or_create_user
      @user = User.find_or_initialize_by(
        phone_number: @response["phone_number"],
        digits_id:    @response["id_str"]
      )
    end
end
