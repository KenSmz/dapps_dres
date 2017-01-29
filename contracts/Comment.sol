pragma solidity ^0.4.4;

contract Comment {
    address userAddress;
    string commentName;
    uint8 goodActionNum;
    uint8 badActionNum;
    string evaluation;
    string gpsLatitude;
    string gpsLongitude;
    uint timestamp;

    function Comment(
      string _name,
      string _evaluation,
      string _gpsLatitude,
      string _gpsLongitude
    ) {
        userAddress = tx.origin;
        commentName = _name;
        evaluation = _evaluation;
        gpsLatitude = _gpsLatitude;
        gpsLongitude = _gpsLongitude;
        timestamp = now;
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

    function getUserAddress() constant returns (address value) {
      return userAddress;
    }

    function getCommentName() constant returns (string value) {
      return commentName;
    }

    function getGoodActionNum() constant returns (uint8 value) {
      return goodActionNum;
    }

    function getBadActionNum() constant returns (uint8 value) {
      return badActionNum;
    }

    function getEvaluation() constant returns (string value) {
      return evaluation;
    }

    function getGpsLatitude() constant returns (string value) {
      return gpsLatitude;
    }

    function getGpsLongitude() constant returns (string value) {
      return gpsLongitude;
    }

    function getTimestamp() constant returns (uint value) {
      return timestamp;
    }
}
