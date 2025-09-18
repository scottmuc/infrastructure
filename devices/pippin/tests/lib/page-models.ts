import { Page } from "playwright";
import { expect, Locator } from "@playwright/test";

export class LoginPage {
  readonly page: Page;
  readonly url: string;

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

export class RecentlyAddedPage {
  readonly page: Page;
  readonly url: string;

  constructor(baseUrl: string, page: Page) {
    this.page = page;
    this.url = constructUrl(baseUrl, "app/#/album/recentlyAdded");
  }

  get navigationTitle(): Promise<string> {
    return this.page.locator("#react-admin-title").innerText();
  }

  async fillAndSubmitSearch(text: string) {
    await this.page.fill("input[id='search']", text);
    await this.page.waitForTimeout(2000);
  }

  async clickOnSearchResult(albumName: string) {
    await this.page.click(`img[alt='${albumName}']`);
    await this.page.waitForTimeout(500);
  }
}

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

export class MusicPlayer {
  readonly className: string;
  readonly page: Page;
  readonly audioTitleSelector: string;

  constructor(page: Page) {
    this.page = page;
    this.className = "music-player-panel";
    this.audioTitleSelector = "span.audio-title";
  }

  async isVisible(): Promise<boolean> {
    return this.page.locator(`div.${this.className}`).isVisible();
  }

  async playingSongShouldBe(audioTitle: string) {
    const locator = this.page.locator(`${this.audioTitleSelector}`);
    expect(locator).toContainText(audioTitle);
  }
}

export class AlbumDetailPage {
  readonly page: Page;
  readonly url: string;
  readonly bandNameHeadingSelector: string;
  readonly musicPlayer: MusicPlayer;

  constructor(baseUrl: string, page: Page) {
    this.page = page;
    this.url = constructUrl(baseUrl, "app/#/album");
    this.bandNameHeadingSelector = "h6 a";
    this.musicPlayer = new MusicPlayer(page);
  }

  get bandNameHeadingLocator(): Locator {
    return this.page.locator(this.bandNameHeadingSelector);
  }

  async clickSong(songTitle: string) {
    await this.page.click(`span:has-text("${songTitle}")`);
    await this.page.waitForTimeout(500);
  }
}
