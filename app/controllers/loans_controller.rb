class LoansController < ApplicationController
  skip_before_action :verify_authenticity_token
  def edit
    begin
      @loan = Loan.find(params[:id])
      respond_to do |format|
        format.json { render json: { loan: @loan},status: :ok }
        format.html
      end
    rescue Exception => e
      respond_to do |format|
        format.json { render json: { message: e.message }, status: :unprocessable_entity }
        format.html 
      end
    end
  end

  def new
    @loan = Loan.new
    @account = Account.find(params[:account])
    respond_to do |format|
      format.json { render json: { loan: @loan},status: :ok }
      format.html
    end
  end

  def create
    @loan = Loan.create(loan_params)
    if @loan.save
      respond_to do |format|
        format.json { render json: { loan: @loan }, status: :ok }
        format.html { redirect_to account_path(@loan.account_id) }
      end
    else
      flash[:notice] = 'Invalid Input'
      respond_to do |format|
        format.json { render json: { message: @loan.errors }, status: :unprocessable_entity }
        format.html { redirect_to account_path(@loan.account_id) }
      end
    end
  end

  def show
    begin
      @loan = Loan.find(params[:id])
      respond_to do |format|
        format.json { render json: { loan: @loan }, status: :ok }
        format.html
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  def update
    @loan = Loan.find(params[:id])
    if @loan.update_attributes(loan_params)
      respond_to do |format|
        format.json { render json: { loan: @loan }, status: :ok }
        format.html { redirect_to account_path(@loan.account_id) }
      end
    else
      flash[:notice] = 'Invalid Input!'
      respond_to do |format|
        format.json { render json: { message: @loan.errors }, status: :unprocessable_entity }
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
      @loan = Loan.find(params[:id])
      @loan.destroy
      respond_to do |format|
        format.json { render json: { message: 'Deleted' }, status: :ok }
        format.html { redirect_to account_path(@loan.account_id) }
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  def loan_params
    params.require(:loan).permit(:category, :amount, :no_of_years, :account_id)
  end
end
