import { formatUserGreeting } from "../src/index";

describe("formatUserGreeting", () => {
  it("formats greeting with role properly", () => {
    expect(formatUserGreeting("Alice", "admin")).toBe("Welcome, Alice (ADMIN)!");
  });

  it("throws on empty name", () => {
    expect(() => formatUserGreeting("", "user")).toThrow("Name cannot be empty");
  });
});
