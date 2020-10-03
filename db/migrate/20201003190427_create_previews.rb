class CreatePreviews < ActiveRecord::Migration[5.2]
  def change
    create_table :previews do |t|

      t.timestamps
    end
  end
end
