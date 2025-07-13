import { expect } from "@playwright/test";

export class TestConfig {
  baseUrl: string;
  username: string;
  password: string;
  testEnvironment: string;

  constructor() {
    this.baseUrl = process.env.NAVIDROME_BASE_URL || "";
    this.username = process.env.NAVIDROME_USERNAME || "";
    this.password = process.env.NAVIDROME_PASSWORD || "";
    this.testEnvironment = process.env.NAVIDROME_TEST_ENVIRONMENT || "local";
    this.verifyEnvVariablesAreSet();
  }

  verifyEnvVariablesAreSet() {
    let message = "The following environment variables are not set:\n";
    try {
      expect(this.baseUrl.length).toBeGreaterThan(0);
      message += "NAVIDROME_BASE_URL \n";
      expect(this.username.length).toBeGreaterThan(0);
      message += "NAVIDROME_USERNAME \n";
      expect(this.password.length).toBeGreaterThan(0);
      message += "NAVIDROME_PASSWORD \n";
      expect(this.testEnvironment.length).toBeGreaterThan(0);
      message += "NAVIDROME_TEST_ENVIRONMENT \n";
    } catch (error) {
      console.error(message);
      throw error;
    }
  }
}
