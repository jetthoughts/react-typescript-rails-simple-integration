const { defaults } = require('jest-config');

module.exports = {
  // to edit default jest configs: https://jestjs.io/docs/en/configuration.html
  moduleFileExtensions: [...defaults.moduleFileExtensions, 'ts', 'd.ts'],

  collectCoverage: true, // comment out to debug through all files
  setupFiles: ['<rootDir>/test/globalHooks.ts'], // comment out for console logs from tests
  verbose: true,
  preset: 'ts-jest',
  testMatch: [
    '<rootDir>/test/**/*.spec.ts', // unit tests
    '<rootDir>/test/**/*.test.ts', // integ tests
  ],
  collectCoverageFrom: ['<rootDir>/src/**/*.ts'],
  coveragePathIgnorePatterns: [
    '<rootDir>/src/gsf-ge-lambda/model/*', // models
    '<rootDir>/src/gsf-ge-lambda/shared/*', // shared
  ],
  coverageReporters: ['text', 'cobertura', 'text-summary', 'html'],
  // setTimeout: 20000,
  clearMocks: true, // making sure to remock for each test
  coverageThreshold: {
    global: {
      // insist on the highest standards! :D
      statements: 100,
      branches: 95, // strive to make this 100
      functions: 100,
      lines: 100,
    },
  },
};
