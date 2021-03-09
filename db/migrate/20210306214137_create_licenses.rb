class CreateLicenses < ActiveRecord::Migration[6.0]
  def change
    create_table :licenses do |t|
      t.date :paid_till, null: false
      t.decimal :min_version
      t.decimal :max_version

      t.timestamps
    end
  end
end
