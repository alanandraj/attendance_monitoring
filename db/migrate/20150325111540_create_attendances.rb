class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.date :date
      t.time :in_time
      t.time :out_time
      t.time :total_duration
      t.string :status

      t.timestamps
    end
  end
end
