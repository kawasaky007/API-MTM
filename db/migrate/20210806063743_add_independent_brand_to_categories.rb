class AddIndependentBrandToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :independent_brand, :boolean
  end
end
