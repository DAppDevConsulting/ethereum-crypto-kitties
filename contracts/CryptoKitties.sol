pragma solidity ^0.4.4;

import "zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract CryptoKitties is ERC721Token, Ownable {
  string public constant name = "CryptoKittiesToken";
  string public constant symbol = "CKT";

  struct Kitty {
    uint64 genes;   // 9 properties, each can take up to 20 values. Length of genes is 18
    string name;
    uint8 generation;
  }

  struct Lot {
    address owner;
    uint price;
  }

  Kitty[] kitties;

  mapping (uint256 => Lot) public kittyIdToLot;

  /**
   * Creates a lot associated by _kittyId
   */
  function createLot(uint _kittyId, uint _price) public {
    takeOwnership(_kittyId);  // kittyId == tokenId

    Lot memory _lot = Lot({
      owner: msg.sender,
      price: _price
    });

    kittyIdToLot[_kittyId] = _lot;
  }

  /**
   * Function used to buy a kitty.
   */
  function bid(uint _kittyId) public payable {
    Lot memory _lot = kittyIdToLot[_kittyId];

    require(_lot.owner != address(0));    // Checking if lot exists
    require(msg.value >= _lot.price);     // Checking if price is higher than bid

    address owner = _lot.owner;
    uint price = _lot.price;

    owner.transfer(price);
    transfer(msg.sender, _kittyId);
  }

  function breed(uint _sireId, uint _matronId) public {
    Kitty memory _sire = kitties[_sireId];
    Kitty memory _matron = kitties[_matronId];
  }


  /**
   * Creating a new Kitti (Token) with specified params.
   * Only owner of the contract is allowed.
   */
  function mint(uint64 _genes, string _name) public onlyOwner {
    Kitty memory _kitty = Kitty({genes: _genes, name: _name, generation: 0});

    uint _kittyId = kitties.push(_kitty) - 1;

    _mint(msg.sender, _kittyId);
  }
}
