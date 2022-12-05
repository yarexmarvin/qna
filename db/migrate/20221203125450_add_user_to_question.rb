class AddUserToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :user, index: true, foreign_key: true
  end
end
