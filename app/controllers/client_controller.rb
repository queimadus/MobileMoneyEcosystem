class ClientController < ApplicationController
  def consult

    @cred =current_user.client.credit
  end
end
