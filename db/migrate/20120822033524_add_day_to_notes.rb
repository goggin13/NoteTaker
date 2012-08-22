class AddDayToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :day, :datetime
  end
end
