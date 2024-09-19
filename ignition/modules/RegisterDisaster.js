const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const RegisterDisasterModule = buildModule("RegisterDisasterModule", (m) => {
  const registerdisaster = m.contract("RegisterDisaster");

  return { registerdisaster };
});

module.exports = RegisterDisasterModule;
