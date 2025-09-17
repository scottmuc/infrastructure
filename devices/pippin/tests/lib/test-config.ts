import { expect } from "chai";

export class TestConfig {
  baseUrl: string;
  username: string;
  password: string;
  testEnvironment: string;

  constructor(env = process.env) {
    this.baseUrl = env.NAVIDROME_BASE_URL;
    this.username = env.NAVIDROME_USERNAME;
    this.password = env.NAVIDROME_PASSWORD;
    this.testEnvironment = env.NAVIDROME_TEST_ENVIRONMENT || "local";
    this.verifyEnvVariablesAreSet();
  }

  verifyEnvVariablesAreSet() {
    expect(this.baseUrl, "NAVIDROME_BASE_URL is not set").to.not.be.empty;
    expect(this.username, "NAVIDROME_USERNAME is not set").to.not.be.empty;
    expect(this.password, "NAVIDROME_PASSWORD is not set").to.not.be.empty;
  }
}
