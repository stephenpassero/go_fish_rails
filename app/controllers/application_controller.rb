require 'pusher'

class ApplicationController < ActionController::Base
  def pusher_client
    @pusher_client ||= Pusher::Client.new(
      app_id: '812203',
      key: '2ffc946d2ff557abffef',
      secret: '59b455fd8e1fbda32c7f',
      cluster: 'us2',
      encrypted: true
    )
  end
end
