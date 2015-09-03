class V1::PhoneNumbersController < V1::BaseController
  skip_before_filter :verify_authenticity_token
  def create
    @phone_number = PhoneNumber.find_or_create_by(phone_number: _phone_number_params[:phone_number])
    @phone_number.update(verified: false)
    @phone_number.generate_pin
    @phone_number.send_pin
    render json: {status: "Sended pin"}
  end

  def verify
    @phone_number = PhoneNumber.find_by(phone_number: _verify_phone_number_params[:phone_number])
    @phone_number.verify(_verify_phone_number_params[:pin])
    if  @phone_number.verified
      render json: {status: "Verified pin"}
    else
      render json: {status: "Pin is typed is error"}
    end
  end

  private

  def _phone_number_params
    params.permit(:phone_number)
  end

  def _verify_phone_number_params
    params.permit(:phone_number, :pin)
  end
end
