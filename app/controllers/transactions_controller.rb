class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.save!
    if !calculate(@transaction).nil?
      account = Account.find(@transaction.account_id)
      account.update_attributes(balance: calculate(@transaction))
      respond_to do |format|
        format.json { render json: { transaction: @transaction }, status: :ok }
        format.html { redirect_to account_path(@transaction.account_id) }
      end
    elsif calculate(@transaction).nil?
      @transaction.destroy
      flash[:notice] = 'Invalid Input'
      respond_to do |format|
        format.json { render json: { message: @transaction.errors }, status: :unprocessable_entity }
        format.html { redirect_to :back }
      end
    end
  rescue Exception => e
    flash[:notice] = 'Invalid Input'
    respond_to do |format|
      format.json { render json: { message: e.message }, status: :unprocessable_entity }
      format.html { redirect_to :back }
    end
  end

  def calculate(cal)
    account = Account.find(cal.account_id)
    if (cal.category == 'deposit') && (cal.amount > 0)
      balance = cal.amount + account.balance
      return balance
    elsif (cal.category == 'withdraw') && (cal.amount <= account.balance) && (cal.amount > 0)
      balance = (account.balance - cal.amount)
      return balance
    else
      return nil
    end
  end

  def show
    begin
      @transaction = Transaction.find(params[:id])
      respond_to do |format|
        format.json { render json: { transaction: @transaction }, status: :ok }
        format.html
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update_attributes(transaction_params)
      render json: { transaction: @transaction }, status: :ok
    else
      render json: { message: @transaction.errors }, status: :unprocessable_entity
    end
  rescue Exception => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def destroy
    begin
      @transaction = Transaction.find(params[:id])
      @transaction.destroy
      respond_to do |format|
        format.json { render json: { message: 'Deleted' }, status: :ok }
        format.html { redirect_to account_path(@transaction.account_id) }
      end
    rescue Exception => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:number, :category, :amount, :account_id)
  end
end
