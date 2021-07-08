class AddParamsToPreviews < ActiveRecord::Migration[5.2]
  def change
    add_column :previews, :str_input, :string
    add_index :previews, :str_input
    add_column :previews, :json_output, :text
  end
end
