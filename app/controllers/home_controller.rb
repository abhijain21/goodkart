class HomeController < ApplicationController

    def index
        @categories = Category.all
        @products = Product.includes(:category).order("Rand()").first(30)
    end

    def search
        products = Product.search( Riddle::Query.escape(params[:query]), 
                                    :star => true, 
                                    :order => 'category_id ASC, @weight DESC',
                                    :sort_mode => :extended,
                                    :include => :category
                                )
        products = products.group_by(&:category)
        res = []
		products.each do |category, products|
			res << {:type=> 'cat', :id => category.id, :label => category.name}
			products.each_with_index do |product,index|
				res << {:type=> 'prod', :id => product.id, :label => product.title}
				break if index>2
			end
		end

        respond_to do |format|
            format.js {render json: res.to_json}
        end
    end

end
