class Api::LimitsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def show
    limits = current_user.client.limits
    if(limits != nil)
      result = {:success => true}
      result.merge(:content => [] )
      content = []
      limits.each do |limit|
        cat = Category.find(limit.category_id)
        limitshow = {     :category => cat.name,
                          :max => limit.max,
                          :type => limit.period,
                          :credit_percentage => limit.credit_percentage,
                          :time_percentage => limit.time_percentage
        }

        content << limitshow
      end
      result[:content] = content
    else
      result = {:success => false}
    end

    render :json=> result
  end
end
