class AddAnswerToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :comment, index: true, foreign_key: true
  end
end
