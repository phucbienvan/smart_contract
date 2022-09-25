pragma // https://uniswap.org/docs/v2/smart-contracts/pair-erc-20/
// https://github.com/Uniswap/uniswap-v2-core/blob/master/contracts/UniswapV2Pair.sol implementation
// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0;

interface IUniswapV2ERC20 {
  event Approval(address indexed owner, address indexed spender, uint value);
  event Transfer(address indexed from, address indexed to, uint value);

  function name() external pure returns (string memory);
  function symbol() external pure returns (string memory);
  function decimals() external pure returns (uint8);
  function totalSupply() external view returns (uint);
  function balanceOf(address owner) external view returns (uint);
  function allowance(address owner, address spender) external view returns (uint);

  function approve(address spender, uint value) external returns (bool);
  function transfer(address to, uint value) external returns (bool);
  function transferFrom(address from, address to, uint value) external returns (bool);

  function DOMAIN_SEPARATOR() external view returns (bytes32);
  function PERMIT_TYPEHASH() external pure returns (bytes32);
  function nonces(address owner) external view returns (uint);

  function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;
};

contract Crud {
    struct User {
        uint id;
        string name;
    }
    User[] public users;
    uint public nextId;
    
    function create(string memory name) public {
        users.push(User(nextId, name));
        ++nextId;
    }
    
    function read(uint id) view public returns(uint, string memory) {
        uint index = find(id);
        return (users[index].id, users[index].name);
    }
    
    function update(uint id, string memory name) public {
        uint index = find(id);
        users[index].name = name;
    }
    
    function deleteUser(uint id) public {
        uint index = find(id);
        delete users[index];
    }
    
    function find(uint id) view internal returns(uint) {
        for(uint i = 0; i < users.length; i++) {
            if(users[i].id == id) {
                return i;
            }
        }
        revert('User does not exits');
    }
}
}
