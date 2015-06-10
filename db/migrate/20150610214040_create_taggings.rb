class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.string :tag_topic_id
      t.string :short_url_id
    end
  end
end
