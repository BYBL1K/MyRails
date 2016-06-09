class ItemsController < ApplicationController
	
	# filters
	before_filter	:find_item, only: [:show, :edit, :update, :destroy, :upvote]
	#before_filter	:check_if_admin, only: [:edit, :update, :new, :create, :destroy]

	# CRUD actions

	# /items GET
	# объект activerecord relation
	def index
		@items = Item
		@items = @items.where("price >= ?", params[:price_from]) 		if params[:price_from]
		@items = @items.where("created_at >= ?", 1.day.ago) 			if params[:today]
		@items = @items.where("votes_count >= ?", params[:votes_from]) 	if params[:votes_from]
		@items = @items.order("votes_count DESC, price")
		# @items = @items.includes(:image)
	end

	def expensive
		@items = Item.where("price > 1000")
		render "index"
	end

	# /items/id GET
	def show
		# намеренный вызов ошибки raise "exeption test!"
		# полезный гем для того, чтобы видеть ошибки
		unless @item
			render text: "Page not found", status: 404
		end
	end
	# /items/new GET
	def new
		@item = Item.new
	end
	# /items/1/edit GET
	def edit
	end
	# /items POST
	def create
		@item = Item.create(item_params)
		if @item.errors.empty?
			redirect_to item_path(@item) # /items/:id
		else
			render "new"
		end
	end
	# /items/1 PUT method work around by rails
	def update
		@item.update_attributes(item_params)
		if @item.errors.empty?
			flash[:success] = "Item successfully updated!"
			redirect_to item_path(@item) # /items/:id
		else
			flash.now[:error] =  "You made mistakes in your form"
			render "edit"
		end
	end
	# /items/1 DELETE
	def destroy
		@item.destroy
		render json: { success: true}
		ItemsMailer.item_destroyed(@item).deliver
	end

	def upvote
		@item.increment!(:votes_count)
		redirect_to action: "index"
	end

	private
		
		def find_item
			@item = Item.where(id: params[:id]).first
			render_404 unless @item
		end

		def item_params
			params.require(:item).permit(:name, :price, :description, :weight)
			# если запрещать нечего: permit!
		end

end
