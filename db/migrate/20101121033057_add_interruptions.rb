class AddInterruptions < ActiveRecord::Migration
  def self.up
    add_column :pomodoros, :internal_interruptions, :integer, :default => 0, :null => false
    add_column :pomodoros, :external_interruptions, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :pomodoros, :internal_interruptions
    remove_column :pomodoros, :external_interruptions
  end
end
