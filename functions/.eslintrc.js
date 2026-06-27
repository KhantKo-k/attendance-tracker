module.exports = {
  root: true,
  env: {
    es2022: true,
    node: true,
  },
  extends: ["eslint:recommended", "google"],
  parserOptions: {
    ecmaVersion: 2022,
  },
  rules: {
    "max-len": ["error", {code: 100}],
    "object-curly-spacing": ["error", "never"],
    "require-jsdoc": "off",
  },
};
