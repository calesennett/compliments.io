class AddFrequencyAndMessageOnToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :frequency, :string
    add_column :users, :message_on, :date
  end

  def down
    remove_column :users, :frequency
    remove_column :users, :message_on
  end
end
