class CreatePomodoros < ActiveRecord::Migration
  def self.up
    create_table :pomodoros do |t|
      t.boolean :success, :default=>false, :null=>false
      t.boolean :finished, :default=>false, :null=>false
      t.datetime :start_time, :null=>false
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :pomodoros
  end
end
