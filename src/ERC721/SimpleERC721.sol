// SPDX-License-Identifier: AGPL-1.0
pragma solidity 0.8.9;

import "./ERC721Base.sol";
import "base64-sol/base64.sol";

contract SimpleERC721 is ERC721Base {
    uint256 _lastId;

    function uint2str(uint256 num) private pure returns (string memory _uintAsString) {
        num += 11;
        unchecked {
            if (num == 0) {
                return "0";
            }

            uint256 j = num;
            uint256 len;
            while (j != 0) {
                len++;
                j /= 10;
            }

            bytes memory bstr = new bytes(len);
            uint256 k = len - 1;
            while (num != 0) {
                bstr[k--] = bytes1(uint8(48 + (num % 10)));
                num /= 10;
            }

            return string(bstr);
        }
    }

    // function tokenURI(uint256 tokenId) external pure returns (string memory) {
    //     string memory tokenIdStr = uint2str(tokenId);
    //     return
    //         string(
    //             abi.encodePacked(
    //                 // solhint-disable quotes
    //                 'data:text/plain,{"name":"Token ',
    //                 tokenIdStr,
    //                 '","description":"Token ',
    //                 tokenIdStr,
    //                 "\",\"image\":\"data:image/svg+xml,<svg viewBox='0 0 32 16' xmlns='http://www.w3.org/2000/svg'><text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' style='fill: rgb(219, 39, 119); font-size: 12px;'> Hello ",
    //                 tokenIdStr,
    //                 '</text></svg>"}'
    //             )
    //         );
    // }

    // function tokenURI(uint256 tokenId) external pure returns (string memory) {
    //     string memory tokenIdStr = uint2str(tokenId);
    //     return
    //         string(
    //             abi.encodePacked(
    //                 // solhint-disable quotes
    //                 'data:application/json,{"name":"Token%20',
    //                 tokenIdStr,
    //                 '","description":"%20Token%20',
    //                 tokenIdStr,
    //                 "\",\"image\":\"data:image/svg+xml,<svg%20viewBox='0%200%2032%2016'%20xmlns='http://www.w3.org/2000/svg'><text%20x='50%'%20y='50%'%20dominant-baseline='middle'%20text-anchor='middle'%20style='fill:%20rgb(219, 39, 119);%20font-size:%2012px;'>%20Hello%20",
    //                 tokenIdStr,
    //                 '</text></svg>"}'
    //             )
    //         );
    // }

    function tokenURI(uint256 tokenId) external pure returns (string memory) {
        string memory tokenIdStr = uint2str(tokenId);
        return
            string(
                abi.encodePacked(
                    // solhint-disable quotes
                    'data:application/json,{"name":"Token%20',
                    tokenIdStr,
                    '","description":"%20Token%20',
                    tokenIdStr,
                    '","image":"data:image/svg+xml;base64,',
                    Base64.encode(
                        abi.encodePacked(
                            "<svg viewBox='0 0 32 16' xmlns='http://www.w3.org/2000/svg'><text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' style='fill: rgb(219, 39, 119); font-size: 12px;'> Hello ",
                            tokenIdStr,
                            "</text></svg>"
                        )
                    ),
                    '"}'
                )
            );
    }

    function symbol() external pure returns (string memory) {
        return "SIMPLE";
    }

    function name() external pure returns (string memory) {
        return "SIMPLE ERC721";
    }

    /// @notice Check if the contract supports an interface.
    /// 0x01ffc9a7 is ERC-165.
    /// 0x80ac58cd is ERC-721
    /// 0x5b5e139f is ERC-721 Metadata (tokenURI, symbol, name)
    /// @param id The id of the interface.
    /// @return Whether the interface is supported.
    function supportsInterface(bytes4 id) public pure virtual override returns (bool) {
        return id == 0x01ffc9a7 || id == 0x80ac58cd || id == 0x5b5e139f;
    }

    function mint(uint256 num) external {
        uint256 id = _lastId;
        for (uint256 i = 0; i < num; i++) {
            id++;
            _mint(msg.sender, id);
        }
        _lastId = id;
    }
}
