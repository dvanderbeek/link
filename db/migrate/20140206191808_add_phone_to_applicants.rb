class AddPhoneToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :phone, :string
  end
end
