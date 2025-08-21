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
import { AlbumDetailPage, HomePage, LoginPage } from "../lib/page-models";
// This must be called in a global scope, otherwise it gets reset.
// https://github.com/cucumber/cucumber-js/blob/HEAD/docs/support_files/timeouts.md
setDefaultTimeout(600000);

// export class LoginPage {
//   readonly page: Page;
//   readonly url: string;

//   constructor(baseUrl: string, page: Page) {
//     this.page = page;
//     this.url = constructUrl(baseUrl, "/app/#/login");
//   }

//   async goto() {
//     await this.page.goto(this.url);
//   }

//   async login(username: string, password: string) {
//     await this.page.fill("input[name='username']", username);
//     await this.page.fill("input[name='password']", password);
//     await this.page.click("button[type='submit']");
//     await this.page.waitForTimeout(500);
//     expect(this.page.url()).toContain(
//       "/app/#/album/recentlyAdded?sort=recently_added&order=DESC&filter={}"
//     );
//   }
// }

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

  const homePage = new HomePage(testConfig.baseUrl, page);
  expect(homePage.titleLocator).toHaveText(
    "Navidrome  - Albums - Recently Added"
  );
});

When(
  "I navigate to the album {string} by the band {string}",
  async function (albumName, bandName) {
    const baseUrl = testConfig.baseUrl;
    const homePage = new HomePage(baseUrl, page);
    await homePage.searchForText(albumName);
    await homePage.clickAlbum(albumName);

    const albumDetailsPage = new AlbumDetailPage(baseUrl, page);
    expect(albumDetailsPage.bandNameHeadingLocator).toHaveText(bandName);
  }
);

When("I play {string}", async function (songTitle) {
  const baseUrl = testConfig.baseUrl;
  const albumDetailPage = new AlbumDetailPage(baseUrl, page);
  await albumDetailPage.clickSongByTitle(songTitle);

  expect(albumDetailPage.musicPlayer.isVisible()).toBeTruthy();
  await page.waitForTimeout(500);

  expect(
    albumDetailPage.musicPlayer.isAudioTitleVisible(songTitle)
  ).toBeTruthy();
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
