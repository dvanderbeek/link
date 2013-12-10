class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :email
      t.string :school
      t.decimal :balance
      t.decimal :rate

      t.timestamps
    end
  end
end
