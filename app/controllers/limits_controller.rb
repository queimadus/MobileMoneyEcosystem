class LimitsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_client!

  # GET /limits
  # GET /limits.json
  def index
    q = Limit.find_all_by_client_id(current_user.client.id)
    @limits = Kaminari.paginate_array(q).page(params[:page]).per(10)

    @l = Limit.new
    @l.client=current_user.client
    @l.max=30
    @l.period="yearly"
    @l.category=Category.find(3)
    @l.starting=DateTime.now.to_date

    respond_to do |format|
      format.json { render :json => {:success => true, :html => render_to_string( :partial => 'limits_list',
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
      format.json { render :json => {:success => true,:id => params[:id], :html => render_to_string( :partial => 'container',

                                                                                  :locals => {:limit => @limit})}}
      format.html # new.html.erb

    end
  end

  # GET /limits/new
  # GET /limits/new.json
  def new
    @limit = Limit.new
    @limit.starting = DateTime.now.to_date


    respond_to do |format|
      format.json { render :json => {:success => true, :html => render_to_string( :partial => 'new',
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


    respond_to do |format|
      if @limit.save
        format.html { redirect_to @limit, notice: 'Limit was successfully created.' }
        format.json { render json: @limit, status: :created, location: @limit }
      else
        format.html { render action: "new" }
        format.json { render json: @limit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /limits/1
  # PUT /limits/1.json
  def update
    @limit = Limit.find(params[:id])

    respond_to do |format|
      if @limit.update_attributes(params[:limit])
        format.json { render :json => {:success => true,
                                       :id => params[:id],
                                       :html => render_to_string( :partial => 'container',
                                                                  :locals => {:limit => @limit})}}
        format.html # new.html.erb
      else
        format.html { render action: "edit" }
        #format.json { render json: @limit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /limits/1
  # DELETE /limits/1.json
  def destroy
    @limit = Limit.find(params[:id])
    @limit.destroy

    respond_to do |format|
      format.html { redirect_to limits_url }
      format.json { head :no_content }
    end
  end
end
