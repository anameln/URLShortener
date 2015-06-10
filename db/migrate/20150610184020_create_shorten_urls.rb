class CreateShortenUrls < ActiveRecord::Migration
  def change
    create_table :shorten_urls do |t|

      t.string :long_url
      t.string :short_url
      t.integer :submitter_id
    end

    add_index :shorten_urls, :submitter_id
    add_index :shorten_urls, :short_url, unique: true
  end
end
