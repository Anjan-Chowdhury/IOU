class DebtsController < ApplicationController
	include ApplicationHelper
	
	def create
    @debt = Debt.new(params[:debt])
    print "###PARAMS DEBT"
    print params[:debt]
    @debt.is_a_payment = true
    @debt.creditor_id = current_user.id
    @debt.creditor_name = current_user.guest == true ? "You" : current_user.name
    
    if @debt.valid?
    	@debt.save
    	flash[:notice] = "Payment successfully recorded."
    	redirect_to debt_url(@debt)
    else
    	flash[:notice] = "Unable to record payment. Try again."
    	render :new
    end
	end

	def new
		@user = current_user
		@debt = Debt.new
		render :new
	end

	def show
		@debt = Debt.find(params[:id])
		render :show
	end

	def paymentconfirmation
		@debt = Debt.find(params[:id])
		email = params[:email]
    DebtMailer.payment_confirmation(email, @debt).deliver  
    redirect_to root_url, notice: 'Payment confirmation sent.'
	end
end
