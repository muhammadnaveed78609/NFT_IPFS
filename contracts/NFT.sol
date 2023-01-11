//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFT is ERC721Enumerable, Ownable {
    using Strings for uint;
    string public _baseURL;
    uint public price = 0.01 ether;
    uint public tokenId;
    bool public paused;
    uint maxtokenIds = 10;
    modifier OnlyWhenNotPaused() {
        require(!paused, "Currently Not Paused");
        _;
    }

    constructor(string memory _tokenbaseURL) ERC721("Naveed Token", "NT") {
        _baseURL = _tokenbaseURL;
    }

    function Mint() public payable OnlyWhenNotPaused {
        require(tokenId <= maxtokenIds, "You Exceed the limit");
        require(msg.value >= price, "Pay Exact price");
        tokenId++;
        _safeMint(msg.sender, tokenId);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURL;
    }

    function tokenURI(
        uint _tokenId
    ) public view virtual override returns (string memory) {
        require(_exists(_tokenId), "Cannot present ID here");
        string memory baseURI = _baseURI();
        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
                : "";
    }

    function setPaused(bool _paused) public onlyOwner {
        paused = _paused;
    }

    function withdraw() public {
        address _owner = owner();
        uint balance = address(this).balance;
        (bool sent, ) = _owner.call{value: balance}("");
        require(sent, "Failed to sent ether");
    }

    receive() external payable {}

    fallback() external payable {}
}
