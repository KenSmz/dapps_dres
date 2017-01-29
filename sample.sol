pragma solidity ^0.4.4;

contract CommentMaster {
    mapping(address => Comment) private comment;
    address[] private addressList;

    function addComment(string _commentName, uint8 _evaluation, uint _gpsLatitude, uint _gpsLongitude, uint _timestamp) {
        Comment c = new Comment(_commentName, _evaluation, _gpsLatitude, _gpsLongitude, _timestamp);
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
    uint8 evaluation;
    uint gpsLatitude;
    uint gpsLongitude;
    uint timestamp;

    function Comment(
      string _name,
      uint8 _evaluation,
      uint _gpsLatitude,
      uint _gpsLongitude,
      uint _timestamp
    ) {
        commentName = _name;
        evaluation = _evaluation;
        gpsLatitude = _gpsLatitude;
        gpsLongitude = _gpsLongitude;
        timestamp = _timestamp;
    }

    function goodCountUp() {
        goodActionNum++;
    }

    function goodCountDown() {
      goodActionNum--;
    }

    function badCountUp() {
        badActionNum++;
    }

    function badCountDown() {
        badActionNum--;
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

    function getEvaluation() constant returns (uint8 number) {
      return evaluation;
    }

    function getGpsLatitude() constant returns (uint value) {
      return gpsLatitude;
    }

    function getGpsLongitude() constant returns (uint value) {
      return gpsLongitude;
    }

    function getTimestamp() constant returns (uint value) {
      return timestamp;
    }
}
