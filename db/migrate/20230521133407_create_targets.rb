class CreateTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :targets do |t|
      t.string :title, null: false
      t.float :radius, null: false
      t.float :lat, null: false
      t.float :lon, null: false
      t.references :user, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.timestamps
      t.check_constraint('radius > 0', name: 'radius_positive')
    end
  end
end
