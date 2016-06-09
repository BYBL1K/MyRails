class Item < ActiveRecord::Base
	# не обязательно для rails 4
	# attr_accessible :price, :real, :weight, :description, :name
	# вылидации для вводимых данных
	validates :price, numericality: { greater_than: 0, allow_nil: true }
	validates :name, presence: true
	# i.save! прерывает и вызывает exeption, если не валидно

	# belongs_to :category

	#after_initialize {} # Item.new, Item.first	
	#after_save 		 {} # Item.save, Item.create, Item.update_attr
	#after_create 	 {}
	#after_update 	 {}
	#after_destroy 	 {}

	has_many :positions
	has_many :carts, through: :positions
	has_many :comments, as: :commentable
	has_and_belongs_to_many :items, 
        class_name: "Item", 
        join_table: :items_orders, 
        foreign_key: :item_id, 
        association_foreign_key: :order_id
end
