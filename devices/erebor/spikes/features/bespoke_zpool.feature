Feature: Bespoke zpool configuration for erebor's data pool

  There are some decisions that can't be changed so I want to ensure that I
  design my zpool correctly before I commit to it. I could use ashift
  autodetection, but since I know the physical sector size of my disks,
  I might as well be explicit. This test can hopefully remind me when
  expaninding the pool to purchase disks with the same physical sectore
  size.

  Scenario: Creating the zpool according to my specifications
    Given 3 disks with 4k physical sectors are attached
    When a zpool called "zdata" with a raidz1 vdev using those disks
    And is created with the "-o ashift=12" option
    Then the zdata pool has an ashift value of 12
    And has a raidz1 vdev with 3 providers
