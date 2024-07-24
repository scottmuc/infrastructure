Feature: A FreeBSD ZFS NAS

  In order to run and maintain a NAS with some features that important for when
  disaster strikes, I want to document my understand of how failures can be
  recovered from so that when it actually happens, I'm not too stressed.

  Scenario: Replacing a failed drive
    Given a 3 disk raidz1 pool with data
    When one of the disks fail
    And I replace the failed drive
    Then my files are all still available

  Scenario: Adding more disk space
  Scenario: Restoring from a snapshot
