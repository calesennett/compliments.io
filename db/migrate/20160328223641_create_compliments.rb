class CreateCompliments < ActiveRecord::Migration[5.0]
  def change
    create_table :compliments do |t|
      t.text :body

      t.timestamps
    end
  end
end
