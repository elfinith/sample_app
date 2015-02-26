class AddContentHtmlToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :content_html, :string
  end
end
