class CreateComentLikeDislikes < ActiveRecord::Migration[7.1]
  def change
    create_table :coment_like_dislikes, id: :uuid do |t|
      t.references :comment, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
