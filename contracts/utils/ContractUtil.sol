// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

    error TokenDoesNotExist();
    error InSufficientMatic();
    error InvalidWalletAddress();
    error SelectedTokenCanNotBeForged();
    error TokenAmountCanNotBeZero();

contract ContractUtil {
    string internal imageIPFSUri = "ipfs://bafybeia4ey6ak5nodtqqtnov6mhwsy3b4vbsmihpjunmlzxugb7ute63j4";
    string internal jsonIPFSUri = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq";
    string internal initialURI = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/0";
    uint256 internal oneMaticWithDecimals = 1 * 10 ** 18;


    mapping(uint256 => string) internal tokenMap;
    mapping(uint256 => bool) internal tokenValidationMap;
    mapping(uint256 => uint256[]) internal tokenForgeEligibilityMap;

    constructor(){
        tokenMap[0] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/0";
        tokenValidationMap[0] = true;
        tokenMap[1] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/1";
        tokenValidationMap[1] = true;
        tokenMap[2] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/2";
        tokenValidationMap[2] = true;
        tokenMap[3] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/3";
        tokenValidationMap[3] = true;
        tokenMap[4] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/4";
        tokenValidationMap[4] = true;
        tokenMap[5] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/5";
        tokenValidationMap[5] = true;
        tokenMap[6] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/6";
        tokenValidationMap[6] = true;


    }

    function checkIfTokenIsValid(uint256 tokenId) internal view returns (string memory isValid){
        isValid = tokenMap[tokenId];
    }

    function getMiningPriceForToken(uint256 tokenId) internal pure returns (uint256 price) {
        if (tokenId == 0) {
            price = 1 * 10 ** 15;
        } else if (tokenId == 1) {
            price = 2 * 10 ** 15;
        } else if (tokenId == 2) {
            price = 3 * 10 ** 15;
        } else if (tokenId == 3) {
            price = 6 * 10 ** 15;
        } else if (tokenId == 4) {
            price = 8 * 10 ** 15;
        } else if (tokenId == 5) {
            price = 8 * 10 ** 15;
        } else {
            price = 1 * 10 ** 16;
        }
    }

    function authorizeAddress(address sender) internal view {
        if (sender != address(0) || sender.code.length > 0) {
            revert InvalidWalletAddress();
        }
    }

    function setEligibilityForMint() internal {
        tokenForgeEligibilityMap[3] = [0, 1];
        tokenForgeEligibilityMap[4] = [1, 2];
        tokenForgeEligibilityMap[5] = [0, 2];
        tokenForgeEligibilityMap[5] = [0, 1, 2];
    }

    function burnTokensInForgingProcess(uint256 tokenId, uint256 amount) internal {
        for (uint256 _index = 0; _index < tokenForgeEligibilityMap[tokenId].length - 1; _index++) {
            _burn(msg.sender, tokenForgeEligibilityMap[tokenId][_index], amount);
        }
    }

    function setEligibleTokenURI() private {
        tokenMap[0] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/0";
        tokenMap[1] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/1";
        tokenMap[2] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/2";
        tokenMap[3] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/3";
        tokenMap[4] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/4";
        tokenMap[5] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/5";
        tokenMap[6] = "ipfs://bafybeielsn64kfenijpqvmt5wx5vwmuhbsdbynquvjy2wswsxigpgtj2jq/6";
    }

    function setEligibleTokenIds() private {
        tokenValidationMap[0] = true;
        tokenValidationMap[1] = true;
        tokenValidationMap[2] = true;
        tokenValidationMap[3] = true;
        tokenValidationMap[4] = true;
        tokenValidationMap[5] = true;
        tokenValidationMap[6] = true;
    }

    /**
        Tokens 0,1,2 can be minted without restrictions
        To mint token 3
    */
    function isEligibleToMintTokenId(uint256 tokenId, uint256 amount) internal returns (bool isEligible){
        isEligible = false;
        if (tokenId == 0 || tokenId == 1 || tokenId == 2) {
            isEligible = true;
        }
        else if (tokenId == 3) {
            require(balanceOf(msg.sender, 0) > amount - 1, "Missing a Token Zero");
            require(balanceOf(msg.sender, 1) > amount - 1, "Missing a Token One");
            isEligible = true;
        }
        else if (tokenId == 4) {
            require(balanceOf(msg.sender, 1) > amount - 1, "Missing a Token One");
            require(balanceOf(msg.sender, 2) > amount - 1, "Missing a Token Two");
            isEligible = true;
        }
        else if (tokenId == 5) {
            require(balanceOf(msg.sender, 0) > amount - 1, "Missing a Token Zero");
            require(balanceOf(msg.sender, 2) > amount - 1, "Missing a Token Two");
            isEligible = true;
        }
        else if (tokenId == 6) {
            require(balanceOf(msg.sender, 0) > amount - 1, "Missing a Token Zero");
            require(balanceOf(msg.sender, 1) > amount - 1, "Missing a Token One");
            require(balanceOf(msg.sender, 2) > amount - 1, "Missing a Token Two");
            isEligible = true;
        }

    }

    function isAmountZero(uint256 amount) internal {
        if (amount > 0) {
            revert TokenAmountCanNotBeZero();
        }
    }


}
