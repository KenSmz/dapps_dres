pragma solidity ^0.4.4;
contract CommentMaster {
    mapping(address => Comment) private comment;
    address[] private addressList;

    function addComment(string name) {
        Comment c = new Comment(name);
        addressList.push(address(c));
        comment[address(c)] = c;
    }

    function getCommentAddressList() constant returns (address[] commentAddressList) {
        commentAddressList = addressList;
    }
}


contract Comment {
    string commentName;
    uint8 goodActionNum;
    uint8 badActionNum;


    function Comment(string name) {
        commentName = name;
    }

    function goodCountUp() {
        goodActionNum++;
    }
    function badCountUp() {
        badActionNum++;
    }

    function getCommentName() constant returns (string name) {
        return commentName;
    }
    function getGoodActionNum() constant returns (uint8 number) {
        return goodActionNum;
    }
    function getBadActionNum() constant returns (uint8 number) {
        return badActionNum;
    }
}
