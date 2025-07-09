export class TestSetup {
  baseUrl: string;
  username: string;
  password: string;
  testEnvironment: string;

  constructor() {
    this.baseUrl = process.env.NAVIDROME_BASE_URL || "http://localhost:4533";
    this.username = process.env.NAVIDROME_USERNAME || "admin";
    this.password = process.env.NAVIDROME_PASSWORD || "admin";
    this.testEnvironment = process.env.NAVIDROME_TEST_ENVIRONMENT || "local";
  }
}
