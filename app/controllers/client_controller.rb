class ClientController < ApplicationController
  def consult
    user = current_user.id
    @cred = Client.where(:user_id => user).credit
  end
end
