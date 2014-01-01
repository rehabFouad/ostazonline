class AddAttachmentAttachmentToTransactions < ActiveRecord::Migration
  def self.up
    change_table :transactions do |t|
      t.attachment :attachment
    end
  end

  def self.down
    drop_attached_file :transactions, :attachment
  end
end
