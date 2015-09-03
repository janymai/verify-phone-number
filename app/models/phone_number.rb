class PhoneNumber < ActiveRecord::Base

  def generate_pin
    self.pin = rand(0000..9999).to_s.rjust(4, "0")
    save
  end

  # Method creates a Twilio REST client
  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def send_pin
    twilio_client.messages.create(
      to: phone_number,
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: "Your PIN is #{pin}"
    )
  end

  # Update status verify
  def verify(entered_pin)
    update(verified: true) if self.pin == entered_pin
  end
end

# export TWILIO_ACCOUNT_SID="AC6ad9ffa99752fd52c5c5351becdddc5e"
# export TWILIO_AUTH_TOKEN="088d40319b4c956ea81e556741c10815"
# export TWILIO_PHONE_NUMBER="+12242315561"
