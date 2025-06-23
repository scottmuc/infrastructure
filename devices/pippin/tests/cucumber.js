module.exports = {
  default: {
    requireModule: ["ts-node/register"],
    require: ["steps/*.ts"],
    paths: ["features/*.feature"],
    format: ["progress-bar"],
    formatOptions: { snippetInterface: "async-await" },
  },
};
