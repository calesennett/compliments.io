require 'active_record'
require 'pg'
require 'twilio-ruby'
require 'iron_worker'
require 'models/user.rb'
require 'models/compliment.rb'

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
  @client = Twilio::REST::Client.new(IronWorker.config['twilio_sid'], IronWorker.config['twilio_auth_token'])
end

def setup_database
  ActiveRecord::Base.establish_connection(
    adapter:  'postgresql',
    host:     IronWorker.config['host'],
    database: IronWorker.config['database'],
    username: IronWorker.config['username'],
    password: IronWorker.config['password']
  )
end

setup_database
setup_twilio
send_messages
