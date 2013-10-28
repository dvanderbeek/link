class RemoveFaqs < ActiveRecord::Migration
  def up
    drop_table :faqs
  end

  def down
    create_table :faqs do |t|
      t.string :question
      t.text :answer

      t.timestamps
    end
  end
end
