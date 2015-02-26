class AddBodyHtmlToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :body_html, :string
  end
end
