var PushStudy = artifacts.require("./PushStudy.sol");
var Election = artifacts.require("./Election.sol");

module.exports = function(deployer) {
  deployer.deploy(PushStudy);
  deployer.deploy(Election);
};
