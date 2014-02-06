class AddEmployerToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :employer, :string
  end
end
