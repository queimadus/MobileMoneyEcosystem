class LimitsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_client!
  include ApplicationHelper
  include ActionView::Helpers::TagHelper

  # GET /limits
  # GET /limits.json
  def index
    q = Limit.where(:client_id => current_user.client.id).order("limits.id DESC")

    if params.has_key?(:q)  and !params{:q}.nil?  and !params[:q].blank?
      @query = params{:q}
      params[:q].split(" ").each do |keyword|
        if(Category.find_by_name(keyword))
          q=q.filter_by_categories(keyword)
          break
        else
          q=q.clear
          break
        end
      end
    end


    @limits = Kaminari.paginate_array(q).page(params[:page]).per(10)

    respond_to do |format|
      format.json { render :json => {:success => true,
                                     :html => render_to_string( :partial => 'limits_list',
                                                                :locals => {:limits => @limits})}}
      format.html { render 'index.html.erb' }
    end
  end

  def gotoindex
    redirect_to limits_path, :alert => "Limit not found"
  end

  # GET /limits/1
  # GET /limits/1.json
  def show


    begin
      @limit = Limit.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return gotoindex
    end

    return gotoindex unless @limit.client_id==current_user.client.id

    respond_to do |format|
      format.json { render :json => {:success => true,
                                     :id => params[:id],
                                     :type => "show",
                                     :html => render_to_string( :partial => 'container',
                                                                :locals => {:limit => @limit})}}
      format.html # new.html.erb

    end
  end

  # GET /limits/new
  # GET /limits/new.json
  def new
    @limit = Limit.new
    @limit.starting = DateTime.now.to_date
    #@limit.errors.clear

    respond_to do |format|
      format.json { render :json => {:success => true,
                                     :html => render_to_string( :partial => 'new',
                                                                :locals => {:limit => @limit})}}
      format.html # new.html.erb
    end
  end

  # GET /limits/1/edit
  def edit
    @limit = Limit.find(params[:id])

    respond_to do |format|
      format.json { render :json => {:success => true,
                                     :id => params[:id],
                                     :html => render_to_string( :partial => 'edit',
                                                                :locals => {:limit => @limit})}}
      format.html # new.html.erb
    end
  end

  # POST /limits
  # POST /limits.json
  def create
    @limit = Limit.new(params[:limit])
    @limit.client_id = current_user.client.id

    good = false

    cond = Limit.where('category_id = ?', params[:limit][:category_id]).
                 where('client_id = ?', current_user.client.id).size

    if cond==0
      good = @limit.save
    else
      @limit.valid?
      @limit.errors[:category_id] = "already exists in limits"
    end

    respond_to do |format|
      if good
        format.json { render :json => {:success => true,
                                       :id => @limit.id,
                                       :type => "new",
                                       :notice => bootstrap_notice("Limit was created successfully", :notice),
                                       :html => render_to_string( :partial => 'container',
                                                                  :locals => {:limit => @limit})}}
        format.html # new.html.erb
      else
        format.json { render :json => {:success => false,
                                      :id => @limit.id,
                                      :type => "new",
                                      :notice => bootstrap_notice(error_on_form_text(@limit.errors), :error),
                                      :html => render_to_string( :partial => 'new',
                                                                 :locals => {:limit => @limit})}}
        format.html # new.html.erb
      end
    end
  end

  # PUT /limits/1
  # PUT /limits/1.json
  def update
    @limit = Limit.find(params[:id])

    good = false

    cond = Limit.where('category_id = ?', params[:limit][:category_id]).
                 where('client_id = ?',params[:limit][:client_id]).
                 where('not id = ?',  @limit.id).size

    if cond==0
      good = @limit.update_attributes(params[:limit])
    else
      @limit.valid?
      @limit.errors[:category_id] = "already exists in limits"
    end

    respond_to do |format|
      if good
        format.json { render :json => {:success => true,
                                       :id => params[:id],
                                       :type => "edit",
                                       :notice => bootstrap_notice("Product was updated successfully", :notice),
                                       :html => render_to_string( :partial => 'container',
                                                                  :locals => {:limit => @limit})}}
        format.html # new.html.erb
      else
        format.json { render :json => {:success => false,
                                       :id => @limit.id,
                                       :type => "edit",
                                       :notice => bootstrap_notice(error_on_form_text(@limit.errors), :error),
                                       :html => render_to_string( :partial => 'edit',
                                                                  :locals => {:limit => @limit})}}
        format.html # new.html.erb
      end
    end
  end

  # DELETE /limits/1
  # DELETE /limits/1.json
  def destroy
    @limit = Limit.find(params[:id])
    @limit.destroy

    respond_to do |format|
      format.json { render :json => {:success => true,
                                     :type => "delete",
                                     :id => params[:id]}}
      format.html { redirect_to limits_url }
    end
  end
end
