setup_database
setup_twilio
send_messages

def send_messages
  User.find_each do |user|
    if user.message_on == Date.today
      send_message(user)
    end
  end
end

def send_message(user)
  random_compliment

  @client.account.messages.create({
    from: '+13093788268',
    to: user.phone_number,
    body: @compliment.body
  })
end

def random_compliment
  @compliment = Compliment.order("RANDOM()").first
end

def setup_twilio
  @client = Twilio::REST::Client.new(params['twilio_sid'], params['twilio_auth_token'])
end

def setup_database
  ActiveRecord::Base.establish_connection(
    adapter:  'postgresql',
    host:     params['host'],
    database: params['database'],
    username: params['username'],
    password: params['password']
  )
end
