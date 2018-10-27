var PushStudy = artifacts.require("./PushStudy.sol");
var Election = artifacts.require("./Election.sol");
var Review = artifacts.require("./Review.sol");

module.exports = function(deployer) {
  deployer.deploy(PushStudy);
  deployer.deploy(Election);
  deployer.deploy(Review);
};
