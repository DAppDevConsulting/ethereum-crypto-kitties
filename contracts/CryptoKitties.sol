pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./GeneticAlgorithm.sol";

contract CryptoKitties is ERC721Token, Ownable, GeneticAlgorithm {
  struct Kitty {
    uint genes;
    string name;
  }

  struct Lot {
    address owner;
    uint price;
  }

  Kitty[] public kitties;

  mapping (uint => Lot) public kittyIdToLot;

  event _KittyCreated(uint _kittyId, address _owner);
  event _LotCreated(uint _kittyId, address _owner);
  event _LotRemoved(uint _kittyId, address _owner);

  function CryptoKitties (string _name, string _symbol) ERC721Token(_name, _symbol) public {}

  /**
   * Creates a lot associated by _kittyId
   */
  function createLot(uint _kittyId, uint _price) public {
    transferFrom(msg.sender, this, _kittyId);  // kittyId == tokenId

    Lot memory _lot = Lot({
      owner: msg.sender,
      price: _price
    });

    kittyIdToLot[_kittyId] = _lot;

    _LotCreated(_kittyId, msg.sender);
  }

  function removeLot(uint _kittyId) public {
    require(kittyIdToLot[_kittyId].owner == msg.sender);

    delete kittyIdToLot[_kittyId];

    transferFrom(this, msg.sender, _kittyId);

    _LotRemoved(_kittyId, msg.sender);
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

    delete kittyIdToLot[_kittyId];

    owner.transfer(price);
    transferFrom(this, msg.sender, _kittyId);
  }

  function breed(uint _sireId, uint _matronId) public {
    Kitty memory _sire = kitties[_sireId];
    Kitty memory _matron = kitties[_matronId];

    uint _genes = mixGenes(_sire.genes, _matron.genes);

    _createKitty(_genes, "New Kitten");
  }

  /**
   * Creating a new Kitti (Token) with specified params.
   * Only owner of the contract is allowed.
   */
  function mint(uint _genes, string _name) public onlyOwner {
    _createKitty(_genes, _name);
  }

  function _createKitty(uint _genes, string _name) internal {
    Kitty memory _kitty = Kitty({genes: _genes, name: _name});

    uint _kittyId = kitties.push(_kitty) - 1;

    _mint(msg.sender, _kittyId);
    _KittyCreated(_kittyId, msg.sender);
  }
}