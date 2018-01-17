class LockersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @lockers = Locker.all
    respond_to do |format|
      format.json { render json: { lockers: @lockers }, status: :ok }
      format.html
    end
  end

  def new
    @locker = Locker.new
    respond_to do |format|
      format.json { render json: { locker: @locker},status: :ok }
      format.html
    end
  end

  def edit
    begin
      @locker = Locker.find(params[:id])
      respond_to do |format|
        format.json { render json: { locker: @locker},status: :ok }
        format.html
      end
    rescue Exception => e
      respond_to do |format|
        format.json { render json: { message: e.message }, status: :unprocessable_entity }
        format.html 
      end
    end
  end

  def create
    @locker = Locker.create(locker_params)
    if @locker.save
      respond_to do |format|
        format.json { render json: { locker: @locker }, status: :ok }
        format.html { redirect_to lockers_path }
      end
    else
      flash[:notice] = 'Invalid Input!'
      respond_to do |format|
        format.json { render json: { message: @locker.errors }, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  def show
    begin
      @locker = Locker.find(params[:id])
      respond_to do |format|
        format.json { render json: { locker: @locker }, status: :ok }
        format.html
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  def update
    @locker = Locker.find(params[:id])
    if @locker.update_attributes(locker_params)
      respond_to do |format|
        format.json { render json: { locker: @locker }, status: :ok }
        format.html { redirect_to lockers_path }
      end
    else
      flash[:notice] = 'Invalid Input!'
      respond_to do |format|
        format.json { render json: { message: @locker.errors }, status: :unprocessable_entity }
        format.html { render 'edit' }
      end
    end
  rescue Exception => e
    flash[:notice] = 'Invalid Input!'
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def destroy
    begin
      @locker = Locker.find(params[:id])
      @locker.destroy
      respond_to do |format|
        format.json { render json: { message: 'Deleted' }, status: :ok }
        format.html { redirect_to lockers_path }
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  def locker_params
    params.require(:locker).permit(:section, :number)
  end
end
