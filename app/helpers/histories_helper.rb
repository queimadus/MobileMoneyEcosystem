module HistoriesHelper

  def filter_categories(product,categories)
      if(categories.nil?)
        return true
      end
      categories.include?(product.categories.first)
  end
end
