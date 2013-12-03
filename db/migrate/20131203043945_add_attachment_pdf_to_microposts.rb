class AddAttachmentPdfToMicroposts < ActiveRecord::Migration
  def self.up
    change_table :microposts do |t|
      t.attachment :pdf
    end
  end

  def self.down
    drop_attached_file :microposts, :pdf
  end
end
