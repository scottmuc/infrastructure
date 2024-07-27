
After do
  @zfs.delete_zpool "testpool"
  @zfs.delete_drive "md3"
  @zfs.delete_drive "md2"
  @zfs.delete_drive "md1"
  @zfs.delete_drive "md0"
end
