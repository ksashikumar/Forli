class AddSentimentToDiscussion < ActiveRecord::Migration[5.1]
  def change
    add_column :discussions, :sentiment, :float, default: 0.0
  end
end
