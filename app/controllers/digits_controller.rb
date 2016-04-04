class DigitsController < ApplicationController
  def create
    set_up_request
    perform_request
    find_or_create_user
    render_response
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

      @req          = Net::HTTP::Get.new(@uri.request_uri, args)
      @response = JSON.parse(http.request(@req).body)
    end

    def find_or_create_user
      if @response["id_str"].present?
        @user = User.find_or_initialize_by(
          phone_number: @response["phone_number"],
          digits_id:    @response["id_str"]
        )

        if @user.new_record?
          @user.update_attributes(
            frequency:  'daily',
            message_on: 1.day.from_now
          )
        end
      else
        @user = nil
      end
    end

    def render_response
      if @user && @user.save
        session[:digits_id] = @user.digits_id
        flash[:notice] = "Thanks for signing up! Please set your message frequency below."
        render js: "document.location = '#{ edit_user_path(@user) }'"
      else
        flash[:notice] = "There was an error logging in. Please try again."
        render js: "document.location = '#{ root_path }'"
      end
    end
end
