pragma solidity ^0.4.4;

import "./Comment.sol";

contract CommentMaster {
    mapping(address => Comment) private comment;
    address[] private addressList;

    function addComment(string _commentName, string _evaluation, string _gpsLatitude, string _gpsLongitude) returns (address contractAddress) {
        Comment c = new Comment(_commentName, _evaluation, _gpsLatitude, _gpsLongitude);
        addressList.push(address(c));
        comment[address(c)] = c;
        return address(c);
    }

    function getCommentAddressList() constant returns (address[] commentAddressList) {
        commentAddressList = addressList;
    }
}
