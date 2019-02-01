class RenameResultToTestPassage < ActiveRecord::Migration[5.2]
  def change
    rename_table :results, :test_passages
    add_reference :test_passages, :current_question, foriegn_key: {to_table: :questions}
    change_column_default :test_passages, :score, from: nil, to: 0
  end
end
