class BillsController < ApplicationController
	include ApplicationHelper
	before_filter :require_login, :except => [:new]

	def index
		@bills = Bill.all
		render :index
	end

	def new
		@user = current_user
		@bill = Bill.new
		render :new
	end

	def create
    bill_id = Bill.last.nil? ? 1 : Bill.last.id + 1
		@bill = Bill.new(:id => bill_id, :user => current_user, :name => params[:bill][:name], :description => params[:bill][:description], :amount => params[:bill][:amount])

		if @bill.valid?
			@bill.save

			print "### Bill Params"
			print params[:bill]
			
	    Bill.calculate(bill_id, params[:bill][:amount].to_i, params[:bill][:guests])

			respond_to do |format|
				format.json { render :json => {:error => "none", :message => "Bill id: #{@bill.id} successfully added."} }
				format.html { redirect_to bill_url(@bill) }
			end
		else
			flash[:notice] = "Error with your bill."
			render :new
		end
	end

	def show
		@bill = Bill.find(params[:id])
		@guests = @bill.guests
		@debts = @bill.debts
		render :show
	end

	def billconfirmation
		@bill = Bill.find(params[:id])
		email = params[:email]
    BillMailer.bill_confirmation(email, @bill).deliver  
    redirect_to root_url, notice: 'Bill confirmation sent.'
	end
end
