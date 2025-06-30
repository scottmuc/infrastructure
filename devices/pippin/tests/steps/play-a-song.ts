/// <reference types="node" />
import { Given, When, After } from "cucumber";
import { chromium, Page, Browser } from "playwright";
import { expect } from "@playwright/test";

let page: Page;
let browser: Browser;

const convertToString = (input: any): string => {
  return input.toString();
};

Given("I am logged in as the testuser", async () => {
  const baseUrl = convertToString(process.env.NAVIDROME_BASE_URL);
  const username = convertToString(process.env.NAVIDROME_USERNAME);
  const password = convertToString(process.env.NAVIDROME_PASSWORD);

  expect(baseUrl.length).toBeGreaterThan(0);
  expect(username.length).toBeGreaterThan(0);
  expect(password.length).toBeGreaterThan(0);

  browser = await chromium.launch({ headless: false });
  page = await browser.newPage();

  await page.goto(`${baseUrl}/music/app/#/login`);
  await page.waitForTimeout(500);
  await page.fill("input[name='username']", username);
  await page.fill("input[name='password']", password);
  await page.waitForTimeout(1000);
  await page.click("button[type='submit']");
  await page.waitForTimeout(1000);

  expect(page.url()).toContain(
    `${baseUrl}/music/app/#/album/recentlyAdded?sort=recently_added&order=DESC&filter={}`
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
