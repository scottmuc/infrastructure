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
import { expect as chaiExpect } from "chai";
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
  chaiExpect(await currentPage.navigationTitle).to.equal(
    "Navidrome - Albums - Recently Added"
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
    chaiExpect(await albumDetailsPage.bandName).to.equal(bandName);
  }
);

When("I play {string}", async function (songTitle) {
  const baseUrl = testConfig.baseUrl;
  const albumDetailPage = new AlbumDetailPage(baseUrl, page);
  await albumDetailPage.clickSong(songTitle);

  const musicPlayer = new MusicPlayer(page);
  musicPlayer.playingSongShouldBe(songTitle);
  chaiExpect(await albumDetailPage.musicPlayer.isVisible()).to.be.true;
  await albumDetailPage.musicPlayer.playingSongShouldBe(songTitle);
});

const convertTimestampToSeconds = (timestamp: string | null): number => {
  if (!timestamp) {
    throw new Error("Timestamp is not found");
  }
  const [minutes, seconds] = timestamp.split(":");
  return Number(minutes) * 60 + Number(seconds);
};

Then("at least 5s of the song is played", async function () {
  const currentTime = page.locator(`span.current-time`);
  await currentTime.waitFor({ state: "visible", timeout: 10000 });
  await page.waitForTimeout(6000);
  const finalTimeText = await currentTime.textContent();
  chaiExpect(convertTimestampToSeconds(finalTimeText)).to.be.greaterThanOrEqual(
    5
  );
});
