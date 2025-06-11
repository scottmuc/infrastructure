Feature: Navidrome Music Streaming

  Scenario: Play a song
    Given I am logged in as the testuser
    When I navigate to the album "Here Comes Science" by the band "They Might Be Giants"
    And I play "Put It To The Test"
    Then at least 5s of the song is played
