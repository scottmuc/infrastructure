/// <reference types="node" />
import {
  Given,
  When,
  After,
  Before,
  Then,
  setDefaultTimeout,
} from "@cucumber/cucumber";
import { chromium, Page, Browser } from "playwright";
import { expect } from "@playwright/test";
import { TestConfig } from "../lib/test-config";
import {
  AlbumDetailPage,
  RecentlyAddedPage,
  LoginPage,
  MusicPlayer,
} from "../lib/page-models";
// This must be called in a global scope, otherwise it gets reset.
// https://github.com/cucumber/cucumber-js/blob/HEAD/docs/support_files/timeouts.md
setDefaultTimeout(600000);

let page: Page;
let browser: Browser;
let testConfig: TestConfig;

Before(async () => {
  testConfig = new TestConfig();
  browser = await chromium.launch({
    headless: testConfig.testEnvironment !== "local",
  });
  page = await browser.newPage();
});

After(async () => {
  if (browser) {
    await browser.close();
  }
});

Given("I am logged in as the testuser", async () => {
  const loginPage = new LoginPage(testConfig.baseUrl, page);
  await loginPage.goto();
  await loginPage.login(testConfig.username, testConfig.password);

  const currentPage = new RecentlyAddedPage(testConfig.baseUrl, page);
  expect(currentPage.titleLocator).toHaveText(
    "Navidrome  - Albums - Recently Added"
  );
});

When(
  "I navigate to the album {string} by the band {string}",
  async function (albumName, bandName) {
    const baseUrl = testConfig.baseUrl;
    const currentPage = new RecentlyAddedPage(baseUrl, page);
    await currentPage.fillAndSubmitSearch(albumName);
    await currentPage.clickOnSearchResult(albumName);

    const albumDetailsPage = new AlbumDetailPage(baseUrl, page);
    expect(albumDetailsPage.bandNameHeadingLocator).toHaveText(bandName);
  }
);

When("I play {string}", async function (songTitle) {
  const baseUrl = testConfig.baseUrl;
  const albumDetailPage = new AlbumDetailPage(baseUrl, page);
  await albumDetailPage.clickSong(songTitle);

  //TODO: albumDetailPage.musicPlayer wait to be visible. do we need the timeout even? POM are better to abstract away the waits
  const musicPlayer = new MusicPlayer(page);
  //TODO: wtf?
  musicPlayer.playingSongShouldBe("nananna");
  expect(albumDetailPage.musicPlayer.isVisible()).toBeTruthy();
  await page.waitForTimeout(500);

  //TODO: see what makes this fail
  // TODO: visibility assertions, expected to see the song title <bllaaa> but i saw <songTitle>
  albumDetailPage.musicPlayer.playingSongShouldBe("songTitle");
});

const convertTimestampToSeconds = (timestamp: string | null): number => {
  if (!timestamp) {
    throw new Error("Timestamp is not found");
  }
  const [minutes, seconds] = timestamp.split(":");
  return Number(minutes) * 60 + Number(seconds);
};

Then("at least 5s of the song is played", async function () {
  await page.waitForTimeout(6000);

  const currentTime = page.locator(`span.current-time`);
  const currentTimeText = await currentTime.textContent();

  expect(convertTimestampToSeconds(currentTimeText)).toBeGreaterThanOrEqual(5);
});
