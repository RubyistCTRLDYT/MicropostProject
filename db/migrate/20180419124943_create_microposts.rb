class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    #我们把user_id 和created_at 放在一个数组中，
    #告诉 Rails 我们要创建的是多键索引（multiple key index），
    #因此 Active Record 会同时使用这两个键。
    add_index :microposts, [:user_id, :created_at]
  end
end
