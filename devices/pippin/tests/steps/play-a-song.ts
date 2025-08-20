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
import { expect, Locator } from "@playwright/test";
import { TestConfig } from "../test-config";
import { HomePage, LoginPage } from "../page-models";
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

  const homePage = new HomePage(testConfig.baseUrl, page);
  expect(homePage.titleLocator).toHaveText(
    "Navidrome  - Albums - Recently Added"
  );
});

When(
  "I navigate to the album {string} by the band {string}",
  async function (albumName, bandName) {
    await page.fill("input[id='search']", albumName);
    await page.waitForTimeout(2000);

    await page.click(`img[alt='${albumName}']`);
    await page.waitForTimeout(500);

    const bandNameHeading = page.locator(`h6 a:has-text("${bandName}")`);
    expect(bandNameHeading).toBeTruthy();
  }
);

When("I play {string}", async function (songTitle) {
  await page.click(`span:has-text("${songTitle}")`);
  const playerElement = page.locator(`div:has-class("music-player-panel")`);
  expect(playerElement).toBeTruthy();
  await page.waitForTimeout(500);

  const audioTitleElement = page.locator(
    `span.audio-title:has-text("${songTitle}")`
  );
  expect(audioTitleElement).toBeTruthy();
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
