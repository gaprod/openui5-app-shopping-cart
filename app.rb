require 'sinatra'
require 'rest-client'
require 'pry'

set :public_folder, File.dirname(__FILE__) + '/app'
set :server, 'webrick'

get '/' do
  html :index
end

post '/mailgun/send' do
	# binding.pry
	send_mail(params)
end

def html(view)
  File.read("app/#{view.to_s}.html")
end

def send_mail(data)
  # binding.pry
  RestClient.post "https://api:key-0c8e3ac5e7f7d1a4282333f2d91801b1"\
  "@api.mailgun.net/v3/sandbox746de4cce1de4b0398fdbf1eac9bf632.mailgun.org/messages",
  :from => "owner@gaprod.herokuapp.com",
  :to => data['userMail'],
  :cc => "kward@gaprod.com.au",
  :subject => "Thank you for shopping with us",
  :html => list_purchase(data)
end

def list_purchase(data)
  html = "<!doctype html><html><head><body>\
          Dear #{data['sUserName']}:\
          <p>Your order with total price <strong>$#{data['order']['totalPrice']}</strong> had been placed.</p>\
          <p>Purchase List:</p>\
          <ul>"
  data.first[1]['entries'].each do |entry|
    html += "<strong>#{entry[-1]['ProductName']}</strong>\
             x #{entry[-1]['Quantity']}\
              ($#{entry[-1]['Price']} each)</li>"
  end
  html += "</ul><hr>\
           <a href='https://gaprod.herokuapp.com/'>Welcome to Gaprod</a>\
           </body></html>"
  return html
end