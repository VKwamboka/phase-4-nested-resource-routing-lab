# class ItemsController < ApplicationController

#   def index
#     items = Item.all
#     render json: items, include: :user
#   end

#   def show

#   end

# end
class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
  
    def index
      if params[:user_id]
        user = find_user
        items = user.items
      else
        items = Item.all
      end
      render json: items, include: :user
    end
  
    def show 
      item = Item.find(params[:id])
      render json: item 
    end
  
    def create 
        user = find_user
        item = user.items.create!(item_params)
        render json: item, status: :created
    end
    
    private 
  
    def find_user
     User.find(params[:user_id])
    end
  
    def item_params 
      params.permit(:name, :description, :price, :user_id)
    end
  
    def user_not_found
      render json: { error: "User not found" }, status: 404
    end
  
  end
