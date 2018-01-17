class AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @accounts = Account.all
    respond_to do |format|
      format.json { render json: { accounts: @accounts }, status: :ok }
      format.html
    end
  end

  def new
    @account = Account.new
    respond_to do |format|
      format.json { render json: { account: @account},status: :ok }
      format.html
    end
  end

  def edit
    begin
      @account = Account.find(params[:id])
      respond_to do |format|
        format.json { render json: { account: @account},status: :ok }
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
    @account = Account.create(account_params)
    if @account.save
      respond_to do |format|
        format.json { render json: { account: @account }, status: :ok }
        format.html { redirect_to user_path(@account.user_id) }
      end
    else
      flash[:notice] = 'Invalid Input!'
      respond_to do |format|
        format.json { render json: { message: 'Account Not Added' }, status: :unprocessable_entity }
        format.html { redirect_to user_path(@account.user_id) }
      end
    end
  end

  def show
    begin
      @account = Account.find(params[:id])
      @account
      respond_to do |format|
        format.json { render json: { account: @account }, status: :ok }
        format.html
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(account_params)
      respond_to do |format|
        format.json { render json: { account: @account }, status: :ok }
        format.html { redirect_to user_path(@account.user_id) }
      end
    else
      flash[:notice] = 'Invalid Input!'
      respond_to do |format|
        format.json { render json: { message: @account.errors }, status: :unprocessable_entity }
        format.html { render 'edit' }
      end
    end
  rescue Exception => e
    flash[:notice] = 'Invalid Input!'
    respond_to do |format|
      format.json { render json: { message: e.message }, status: :unprocessable_entity }
      format.html { render 'edit' }
    end
  end

  def destroy
    begin
      @account = Account.find(params[:id])
      @account.destroy
      respond_to do |format|
        format.json { render json: { message: 'Deleted' }, status: :ok }
        format.html { redirect_to user_path(@account.user_id) }
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:number, :balance, :user_id, :locker_id)
  end
end
