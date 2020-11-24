class AddRuleViolationNumberToEndUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :end_users, :rule_violation_number, :integer, default: 0
  end
end
