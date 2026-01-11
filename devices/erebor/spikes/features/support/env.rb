
After do
  @zfs.delete_zpool @zpool_name
  @zfs.delete_drive "md6"
  @zfs.delete_drive "md5"
  @zfs.delete_drive "md4"
  @zfs.delete_drive "md3"
  @zfs.delete_drive "md2"
  @zfs.delete_drive "md1"
  @zfs.delete_drive "md0"
end
