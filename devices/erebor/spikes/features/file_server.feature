Feature: A FreeBSD ZFS NAS

  In order to run and maintain a NAS with some features that important for when
  disaster strikes, I want to document my understand of how failures can be
  recovered from so that when it actually happens, I'm not too stressed.

  Background:
    Given a 3 disk raidz1 pool
    And it contains some data

  Scenario: Replacing a failed drive
    Given that one of the disks has failed
    When the failed disk is replaced
    Then my files are all still available

  Scenario: Adding more disk space
    Given that new larger drives are connected
    When the drives are replaced one at a time
    Then my zpool has more storage available

  Scenario: Restoring from a snapshot
    Given that a snapshot has been made
    When a file has been deleted
    And I restore from the snapshot
    Then my files are all still available

  Scenario: Importing zdata after OS repave
    Given the "testpool" zpool has been exported
    When the host OS is repaved
    And the "testpool" zpool has been imported
    Then my files are all still available
