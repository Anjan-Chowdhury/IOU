class BillsController < ApplicationController
	def index
		@bills = Bill.all
		render :index
	end

	def new
		@bill = Bill.new
		render :new
	end

	def create
		@bill = Bill.new(params[:bill])
		if @bill.valid?
			@bill.save
			respond_to do |format|
				format.json { render :json => {:error => "none", :message => "Bill id: #{@bill.id} successfully added." } }
				format.html { redirect_to bill_url(@bill) }
			end
		else
			flash[:notice] = "Error with your bill."
			render :new
		end
	end

	def show
		@bill = Bill.find(params[:id])
		render :show
	end
end
