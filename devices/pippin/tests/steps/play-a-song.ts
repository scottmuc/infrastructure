import { Given, When, After } from "cucumber";
import { chromium, Page, Browser } from "playwright";
import { expect } from "@playwright/test";

let page: Page;
let browser: Browser;

Given("I am logged in as the testuser", async () => {
  browser = await chromium.launch();
  page = await browser.newPage();
  const loginUrl = "https://home.scottmuc.com/music/app/#/login";
  await page.goto(loginUrl);
  await page.waitForTimeout(1000);
  await page.fill("input[name='username']", "tester");
  await page.fill("input[name='password']", "scottmucgmbh");
  await page.click("button[type='submit']");
  await page.waitForTimeout(1000);

  expect(page.url()).toContain(
    "https://home.scottmuc.com/music/app/#/album/recentlyAdded?sort=recently_added&order=DESC&filter={}"
  );

  const titleElement = page.locator("#react-admin-title");
  await titleElement.waitFor({ timeout: 10000 });
  const titleText = await titleElement.textContent();

  expect(titleText).toContain("Navidrome  - Albums - Recently Added");
});

When(
  "I navigate to the album {string} by the band {string}",
  async function (albumName, bandName) {
    await page.click("text=Albums");
    await page.click("text=All");

    await page.waitForURL("**/album/**");
    expect(page.url()).toContain(
      "https://home.scottmuc.com/music/app/#/album/"
    );

    await page.fill("input[id='search']", albumName);
    await page.waitForTimeout(2000);
    await page.click("img[aria-label='play']");

    await page.waitForTimeout(2000);
    await page.click("text='Click to pause']");
  }
);

After(async () => {
  if (browser) {
    await browser.close();
  }
});
