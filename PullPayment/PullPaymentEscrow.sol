// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/PullPayment.sol";

contract PullPaymentEscrow is Ownable, AccessControl, PullPayment {
  bytes32 public constant PAYEE_ROLE = keccak256("PAYEE_ROLE");
  bool isApprove = false;
  address public payee;

  constructor(address _payee) payable {
    require(msg.value > 0, "Payment: Must provide funds");
    payee = _payee;
    _grantRole(PAYEE_ROLE, payee);
  }

  function releasePayments() public onlyOwner {
    isApprove = true;
    super._asyncTransfer(payee, address(this).balance);
  }

  function withdrawPayments(address payable _payee) public override onlyRole(PAYEE_ROLE) virtual {
    require(_payee == payee, "Payment: Invalid payee address");
    super.withdrawPayments(_payee);
  }

  function cancelPayments() public onlyOwner {
    require(isApprove == false, "Payment: Payments already released");
    super._asyncTransfer(msg.sender, address(this).balance);
    super.withdrawPayments(payable(msg.sender));
  }
}
