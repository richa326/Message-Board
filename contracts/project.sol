// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageBoard {
    struct Message {
        address sender;
        string content;
        uint256 timestamp;
    }

    Message[] public messages;

    event NewMessage(address indexed sender, string content, uint256 timestamp);

    function postMessage(string calldata _content) external {
        require(bytes(_content).length > 0, "Message cannot be empty");

        Message memory newMsg = Message({
            sender: msg.sender,
            content: _content,
            timestamp: block.timestamp
        });

        messages.push(newMsg);
        emit NewMessage(msg.sender, _content, block.timestamp);
    }

    function getMessageCount() external view returns (uint256) {
        return messages.length;
    }

    function getMessage(uint256 index) external view returns (address, string memory, uint256) {
        require(index < messages.length, "Invalid message index");
        Message memory msgData = messages[index];
        return (msgData.sender, msgData.content, msgData.timestamp);
    }
}
