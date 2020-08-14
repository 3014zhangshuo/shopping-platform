class CreateProductImages < ActiveRecord::Migration[5.2]
  def change
    create_table :product_images do |t|
      t.belongs_to :product
      t.integer :weight
      t.attachment :image
      t.timestamps
    end
  end
end
