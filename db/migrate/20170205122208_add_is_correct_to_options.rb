class AddIsCorrectToOptions < ActiveRecord::Migration
  def change
    add_column :options, :is_correct, :boolean, index: true
  end
end
