/// <reference types="node" />
import { Given, When, After, Before } from "cucumber";
import { chromium, Page, Browser } from "playwright";
import { expect } from "@playwright/test";
import { TestSetup } from "../test-setup";

let page: Page;
let browser: Browser;
let testSetup: TestSetup;

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
  testSetup = new TestSetup();
});

Given("I am logged in as the testuser", async () => {
  const baseUrl = convertToString(testSetup.baseUrl);
  const username = convertToString(testSetup.username);
  const password = convertToString(testSetup.password);
  const testEnvironment = convertToString(testSetup.testEnvironment);

  expect(baseUrl.length).toBeGreaterThan(0);
  expect(username.length).toBeGreaterThan(0);
  expect(password.length).toBeGreaterThan(0);
  expect(testEnvironment.length).toBeGreaterThan(0);

  browser = await chromium.launch({
    headless: testEnvironment !== "local",
  });
  page = await browser.newPage();

  await page.goto(constructUrl(baseUrl, "/app/#/login"));
  await page.waitForTimeout(500);
  await page.fill("input[name='username']", username);
  await page.fill("input[name='password']", password);
  await page.waitForTimeout(1000);
  await page.click("button[type='submit']");
  await page.waitForTimeout(1000);

  expect(page.url()).toContain(
    constructUrl(
      baseUrl,
      "/app/#/album/recentlyAdded?sort=recently_added&order=DESC&filter={}"
    )
  );

  const titleElement = page.locator("#react-admin-title");
  await titleElement.waitFor({ timeout: 10000 });
  const titleText = await titleElement.textContent();

  expect(titleText).toContain("Navidrome  - Albums - Recently Added");
});

When(
  "I navigate to the album {string} by the band {string}",
  async function (albumName, bandName) {
    await page.fill("input[id='search']", albumName);
    await page.waitForTimeout(2000);

    await page.click(`img[alt='${albumName}']`);
    await page.waitForTimeout(2000);

    const bandNameHeading = page.locator(`h6 a:has-text("${bandName}")`);
    await bandNameHeading.waitFor({ timeout: 10000 });
    expect(bandNameHeading).toBeTruthy();
  }
);

After(async () => {
  if (browser) {
    await browser.close();
  }
});
