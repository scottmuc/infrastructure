/// <reference types="node" />
import { Given, When, After, Before, Then, setDefaultTimeout } from "@cucumber/cucumber";
import { chromium, Page, Browser } from "playwright";
import { expect } from "@playwright/test";
import { TestConfig } from "../test-config";

// This must be called in a global scope, otherwise it gets reset.
// https://github.com/cucumber/cucumber-js/blob/HEAD/docs/support_files/timeouts.md
setDefaultTimeout(600000);

export class LoginPage {
  readonly page: Page;
  readonly url: string

  constructor(baseUrl: string, page: Page) {
    this.page = page;
    this.url = constructUrl(baseUrl, "/app/#/login");
  }

  async goto() {
    await this.page.goto(this.url);
  }

  async login(username: string, password: string) {
    await this.page.fill("input[name='username']", username);
    await this.page.fill("input[name='password']", password);
    await this.page.click("button[type='submit']");
    await this.page.waitForTimeout(500);
    expect(this.page.url()).toContain(
        "/app/#/album/recentlyAdded?sort=recently_added&order=DESC&filter={}"
    );
  }
}

let page: Page;
let browser: Browser;
let testConfig: TestConfig;

const convertToString = (input: any): string => {
  return input.toString();
};

const constructUrl = (base: string, path: string): string => {
  // OMG, the URL object will squash the path in the base if
  // the path variable begins with a '/'. Rather than ensuring
  // someone specifies a base WITH a trailing '/' and ensuring
  // someone specifies a path WITHOUT a leading '/', we do some
  // some sanitization of both params to ensure all the following
  // work:
  //
  // base: https://home.scottmuc.com/music
  // path: app/#/login
  //  out: https://home.scottmuc.com/music/app/#/login
  //
  // base: https://home.scottmuc.com/music
  // path: /app/#/login
  //  out: https://home.scottmuc.com/music/app/#/login
  //
  // base: https://home.scottmuc.com/music/
  // path: app/#/login
  //  out: https://home.scottmuc.com/music/app/#/login
  //
  // base: https://home.scottmuc.com/music/
  // path: /app/#/login
  //  out: https://home.scottmuc.com/music/app/#/login
  return new URL(path.replace(/^\/+/g, ""), base.replace(/\/+$/g, "") + "/")
    .href;
};

Before(async () => {
  testConfig = new TestConfig();
});

Given("I am logged in as the testuser", async () => {
  const baseUrl = convertToString(testConfig.baseUrl);
  const username = convertToString(testConfig.username);
  const password = convertToString(testConfig.password);
  const testEnvironment = convertToString(testConfig.testEnvironment);

  browser = await chromium.launch({
    headless: testEnvironment !== "local",
  });
  page = await browser.newPage();

  const loginPage = new LoginPage(baseUrl, page);
  await loginPage.goto();
  await loginPage.login(username, password);

  // TODO: perform this assert on a Page Object
  const titleElement = page.locator("#react-admin-title");
  expect(titleElement).toHaveText("Navidrome  - Albums - Recently Added");
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

After(async () => {
  if (browser) {
    await browser.close();
  }
});
