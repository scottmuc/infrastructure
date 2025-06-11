import { Given } from "cucumber";
import { chromium } from "playwright";
import { expect } from "@playwright/test";

Given("I am logged in as the testuser", async () => {
  console.log("Logging in as testuser...");
  const browser = await chromium.launch();
  const page = await browser.newPage();
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

  await browser.close();
});
