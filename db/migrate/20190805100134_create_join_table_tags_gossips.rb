class CreateJoinTableTagsGossips < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tags, :gossips do |t|
      t.index [:gossip_id, :tag_id]
    end
  end
end
