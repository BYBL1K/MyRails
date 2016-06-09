require 'spec_helper'

describe ItemsController do
	
	it_renders_404_page_when_item_is_not_found :show, :edit, :update, :destroy

	describe "show action" do

		it "renders show template if found" do
			item = create(:item)
			get :show, id: item.id
			expect(response).to render_template("show")
		end

	end

	describe " create action" do

		it "redirects to item_path" do
			post :create, item: { name: "Item 1", price: 20 }
			expect(response).to redirect_to(item_path(assigns(:item)))
		end

		it "renders new page again if failed" do
			post :create, item: { name: "Item 1", price: 0 }
			expect(response).to render_template("new")
		end

	end

	describe "destroy action" do

		it "redirect to index action" do
			item = create(:item)
			delete :destroy, id: item.id # метод вызывающий экшн
			expect(response).to redirect_to(items_path)
		end
	end

end