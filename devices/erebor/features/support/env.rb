
After do
  ZfsFixture.new.delete_zpool "testpool"
  ZfsFixture.new.delete_drive "md3"
  ZfsFixture.new.delete_drive "md2"
  ZfsFixture.new.delete_drive "md1"
  ZfsFixture.new.delete_drive "md0"
end
