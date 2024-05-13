class AddColorToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :color, :string, default: Category.colors[:default]
  end
end
