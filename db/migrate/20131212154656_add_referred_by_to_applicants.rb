class AddReferredByToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :referred_by, :string
  end
end
