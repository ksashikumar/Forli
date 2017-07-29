class AddCorrectAnswerIdDiscussion < ActiveRecord::Migration[5.1]
  def change
    add_column :discussions, :correct_answer_id, :integer
  end
end
