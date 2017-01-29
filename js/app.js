// var url = "https://ropsten.infura.io/dpG8XLk9vFwGePcMDyUZ"
var url = "http://localhost:8545"
var user_name;
var web3 = new Web3();
var provider = new web3.providers.HttpProvider(url)
web3.setProvider(provider);
web3.eth.defaultAccount = "0x5711e8ee69385f6b0607d33eb1ed55fabf609b76";

var ABI = [{"constant":true,"inputs":[],"name":"getBadActionNum","outputs":[{"name":"number","type":"uint8"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"getGoodActionNum","outputs":[{"name":"number","type":"uint8"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"badCountUp","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"goodCountUp","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"getCommentName","outputs":[{"name":"name","type":"string"}],"payable":false,"type":"function"},{"inputs":[{"name":"name","type":"string"}],"payable":false,"type":"constructor"}]

var masterABI = [{"constant":false,"inputs":[{"name":"name","type":"string"}],"name":"addComment","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"getCommentAddressList","outputs":[{"name":"commentAddressList","type":"address[]"}],"payable":false,"type":"function"}]

//接続するContract(CommentMaster)のアドレス
var master = web3.eth.contract(masterABI).at("0x2151558860e0f8d2651aa8d30aad21a1ce57077b");
var CommentAddressList = master.getCommentAddressList();

function login() {
    user_name = $("#userName").val();
    var password = $("#password").val();
    var JSONdata = createJSONdata("personal_unlockAccount", [ user_name, password, 30 ]);
    executeJsonRpc(url, JSONdata, function success(data) {
        if (data.error == null) {
            console.log("login success! : " + data);
            init();
        } else {
            console.log("login error : " + data.error);
        }
    }, function error(data) {
        console.log("login error");
    });
}

//初期処理
function init() {
    web3.eth.defaultAccount = user_name;
    var table = document.getElementById('list');
    
    for (var i = 0; i < CommentAddressList.length; i++) {
        var Comment = web3.eth.contract(ABI).at(CommentAddressList[i]);

        var row = table.insertRow();
        var td = row.insertCell(0);
        var radioButton1 = document.createElement('input');
        radioButton1.type = 'radio';
        radioButton1.name = 'CommentAddress';
        radioButton1.value = CommentAddressList[i];
        td.appendChild(radioButton1);
        td = row.insertCell(1);
        // td.innerHTML = web3.toAscii(Comment.getCommentName());
        td.innerHTML = Comment.getCommentName();
        td = row.insertCell(2);
        td.innerHTML = Comment.getGoodActionNum();
        td = row.insertCell(3);
        td.innerHTML = Comment.getBadActionNum();
    }
}

//更新
function refresh() {
    web3.eth.defaultAccount = user_name;
    var table = document.getElementById('list');
    for (var i = CommentAddressList.length; i > 0; i--) {
        table.deleteRow(i);
    }
    init();
}

//goodカウントアップ
function goodCountUp() {
    web3.eth.defaultAccount = user_name;
    var targetAddress;
    var CommentList = document.getElementsByName("CommentAddress");
    for (i = 0; i < CommentList.length; i++) {
        if (CommentList[i].checked) {
            targetAddress = CommentList[i].value;
        }
    }
    // 対象候補者コントラクトを取得
    var Comment = web3.eth.contract(ABI).at(targetAddress);
    // 対象候補者に投票
    Comment.goodCountUp();
}

function Inputcom(){
    console.log("set comment!");
    var tmp = document.getElementById("inputcom").value
    if (tmp != '') {
        master.addComment(tmp, {gas:300000} );
    } 
}

//JSONメッセージ生成
function createJSONdata(method, params) {
var JSONdata = {
    "jsonrpc" : "2.0",
    "method" : method,
    "params" : params,
    "id" : "1"
    };
    return JSONdata;
}

//JSON-RPC実行
function executeJsonRpc(url_exec, JSONdata, success, error) {
    $.ajax({
        type : 'post',
        url : url_exec,
        data : JSON.stringify(JSONdata),
        contentType : 'application/JSON',
        dataType : 'JSON',
        scriptCharset : 'utf-8',
        success : function(data) {
            success(data);
        },
        error : function(data) {
            error(data);
        }
    });
}