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
		if @bill.save!
			redirect_to bill_url(@bill)
		else
			render :new
		end
	end

	def show
		@bill = Bill.find(params[:id])
		render :show
	end
end
