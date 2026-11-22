export default {
  testEnvironment: 'node',
  transform: {},
  moduleFileExtensions: ['js', 'json'],
  coverageDirectory: 'coverage',
  collectCoverageFrom: [
    'public/js/modules/**/*.js',
    'src/server/**/*.js',
    '!public/js/modules/ui.js',
    '!public/js/modules/sample-data.js',
    '!src/server/server.js'
  ],
  coverageReporters: ['text', 'lcov', 'clover', 'html']
};
