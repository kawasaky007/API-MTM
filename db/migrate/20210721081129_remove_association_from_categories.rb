class RemoveAssociationFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :association, :string
  end
end
