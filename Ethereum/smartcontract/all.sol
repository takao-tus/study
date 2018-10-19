pragma solidity ^0.4.8;

// 所有者管理用コントラクト
contract Owned {
  // 状態変数
  address public owner;     // オーナーアドレス

  // オーナーの移転時のイベント
  event TransferOwnership(address oldaddr, address newaddr);

  // オーナー限定メソッド用の修飾子
  modifier onlyOwner() { if (msg.sender != owner) throw; _; }

  // コンストラクタ
  function Owned() {
    owner = msg.sender;     // 最初はコントラクト作成アドレスをオーナーとする
  }

  // (1) オーナーの移転
  function transferOwnership(address _new) onlyOwner {
    address oldaddr = owner;
    owner = _new;
    TransferOwnership(oldaddr, owner);
  }
}

contract agreement {
      // (１) 状態変数の宣言
  address public coin;            // トークン(仮想通貨)アドレス
  uint256 public agreementeth;
  BuyerStatus[] public Buyerstatus;
  //Buyer構造体
  struct BuyerStatus {
    address buyer;      // 買いたい人のアドレス
    uint256 kwh;        // 買いたい電力量[kwh]
    uint256 value;      // Eth
    uint256 sum;        // 合計の電力量
  }
    SellerStatus[] public Sellerstatus;
  //Seller構造体
  struct SellerStatus {
    address seller;       // 買いたい人のアドレス
    uint256 coin;        // 買いたい電力量[kwh]
    uint256 value;      // Eth 
    uint256 sum;        // 合計の電力量
  }
    // （２）買い手のステイタスの追加
  function pushBuyerStatus(address _buyer, uint256 _kwh, uint256 _value)
    {
    Buyerstatus.push(BuyerStatus({
      buyer: _buyer,
      kwh: _kwh,
      value: _value,
      sum:_kwh
    }));
  }
  //　（３）買い手のステイタスの変更
  function editBuyerStatus(uint256 _index,address _buyer, uint256 _kwh, uint256 _value)
  {
    if (_index < Buyerstatus.length) {
      Buyerstatus[_index].buyer = _buyer;
      Buyerstatus[_index].kwh = _kwh;
      Buyerstatus[_index].value = _value;
      Buyerstatus[_index].sum = _kwh;
    }
  }
    // （２）ステイタスの追加
  function pushSellerStatus(address _seller, uint256 _coin, uint256 _value)
    {
    Sellerstatus.push(SellerStatus({
      seller: _seller,
      coin: _coin,
      value: _value,
      sum: _coin
    }));
  }

  // (３) 会員ステイタスの内容変更
  function editSellerStatus(uint256 _index,address _seller, uint256 _coin, uint256 _value)
  {
    if (_index < Sellerstatus.length) {
      Sellerstatus[_index].seller = _seller;
      Sellerstatus[_index].coin = _coin;
      Sellerstatus[_index].value = _value;
      Sellerstatus[_index].sum = _coin;
    }
  }
    function Agreement (){
    address tmpb;
    uint256 tmpk;
    uint256 tmpv;
    uint256 tmps;
    for (uint256 i = 0; i < Buyerstatus.length; i++) {
        for (uint256 j = (Buyerstatus.length-1); j > i; j--) {
            if (Buyerstatus[j].value > Buyerstatus[j-1].value) {
            tmpb = Buyerstatus[j].buyer;
            tmpk = Buyerstatus[j].kwh;
            tmpv = Buyerstatus[j].value;
            tmps = Buyerstatus[j].sum;
            Buyerstatus[j].buyer = Buyerstatus[j-1].buyer;
            Buyerstatus[j].kwh = Buyerstatus[j-1].kwh;
            Buyerstatus[j].value = Buyerstatus[j-1].value;
            Buyerstatus[j].sum = Buyerstatus[j-1].sum;
            Buyerstatus[j-1].buyer = tmpb;
            Buyerstatus[j-1].kwh = tmpk;
            Buyerstatus[j-1].value = tmpv;
            Buyerstatus[j-1].sum = tmps;
          } 
        }
      }
      //  (5)　kwhの合計値の計算
      for (uint256 k = 1; k < Buyerstatus.length; k++) {
          Buyerstatus[k].sum = Buyerstatus[k].kwh + Buyerstatus[k-1].sum;
    }
    
    address tmpss;
    uint256 tmpc;
    uint256 tmpvv;
    uint256 tmpsum;
        for (uint256 x = 0; x < Sellerstatus.length; x++) {
            for (uint256 y = (Sellerstatus.length-1); y > x; y--) {
                if (Sellerstatus[y].value < Sellerstatus[y-1].value) {
                tmpss = Sellerstatus[y].seller;
                tmpc = Sellerstatus[y].coin;
                tmpvv = Sellerstatus[y].value;
                tmpsum = Sellerstatus[y].sum;
                Sellerstatus[y].seller = Sellerstatus[y-1].seller;
                Sellerstatus[y].coin = Sellerstatus[y-1].coin;
                Sellerstatus[y].value = Sellerstatus[y-1].value;
                Sellerstatus[y].sum = Sellerstatus[y-1].sum;
                Sellerstatus[y-1].seller = tmpss;
                Sellerstatus[y-1].coin = tmpc;
                Sellerstatus[y-1].value = tmpvv;
                Sellerstatus[y-1].sum = tmpsum;
                } 
            }
        }  
        for (uint256 z = 1; z < Sellerstatus.length; z++) {
          Sellerstatus[z].sum = Sellerstatus[z].coin + Sellerstatus[z-1].sum;
        }        
        for (uint256 s = 0; s < Buyerstatus.length; ){
            for (uint256 m = 0; m < Sellerstatus.length; ){
                if(Buyerstatus[s].value > Sellerstatus[m].value){
                    if(Buyerstatus[s].sum <= Sellerstatus[m].sum){
                        s++;
                    }
                    if(Buyerstatus[s].sum > Sellerstatus[m].sum){
                        m++;
                    }
                }
                else{
                    agreementeth = Sellerstatus[m].value;
                    s= Buyerstatus.length;
                    m= Sellerstatus.length;
                }
            }
        }
    }
}  
  // (11) 会員管理機能付き仮想通貨
contract OreOreCoin {
  // (1) 状態変数の宣言
  string public name;                             // トークンの名前
  string public symbol;                           // トークンの単位
  uint8 public decimals;                          // 小数点以下の桁数
  uint256 public totalSupply;                     // トークンの総量
  mapping (address => uint256) public balanceOf;  // 各アドレスの残高

  // (2) イベント通知
  event Transfer(address indexed from, address indexed to, uint256 value);

  // (3) コンストラクタ
  function OreOreCoin(uint256 _supply, string _name, string _symbol, uint8 _decimals) {
    balanceOf[msg.sender] = _supply;
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
    totalSupply = _supply;
  }

  // (4) 送金
  function transfer(address _to, uint256 _value) {
    // (5) 不正送金チェック
    if (balanceOf[msg.sender] < _value) throw;
    if (balanceOf[_to] + _value < balanceOf[_to]) throw;

    // (6) 送信アドレスと受信アドレスの残高を更新
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
    // (7) イベント通知
    Transfer(msg.sender, _to, _value);
  }
}
// (1) エスクロー
contract Escrow is Owned{
  // (2) 状態変数
  OreOreCoin public token; // トークン
  uint256 public salesVolume; // 販売量
  uint256 public sellingPrice; // 販売価格
  uint256 public deadline; // 期限
  bool public isOpened; // エスクローオープンフラグ

  // (3) イベント通知
  event EscrowStart(uint salesVolume, uint sellingPrice, uint deadline, address beneficiary);
  event ConfirmedPayment(address addr, uint amount);

  // (4) コンストラクタ
  function Escrow (OreOreCoin _token, uint256 _salesVolume, uint256 _priceInEther) {
    token = OreOreCoin(_token);
    salesVolume = _salesVolume;
    sellingPrice = _priceInEther * 1 ether;
  }

  // (5) 無名関数(ETH受け取り)
  function () payable {
    // 開始前または期限切れの場合は例外
    if (!isOpened || now >= deadline) throw;
    // 販売価格未満の場合は例外
    uint amount = msg.value;
    if (amount < sellingPrice) throw;

    // 送信者にトークンを転送し、エスクローをオープンフラグをfalseにする
    token.transfer(msg.sender, salesVolume);
    isOpened = false;
    ConfirmedPayment(msg.sender, amount);
  }

  // (6) 開始(トークンが予定数以上あるなら開始)
  function start(uint256 _durationInMinutes) onlyOwner {
    if (token == address(0) || salesVolume == 0 || sellingPrice == 0 || deadline != 0) throw;
    if (token.balanceOf(this) >= salesVolume){
      deadline = now + _durationInMinutes * 1 minutes;
      isOpened = true;
      EscrowStart(salesVolume, sellingPrice, deadline, owner);
    }
  }

  // (7) 残り時間確認用メソッド(分単位)
  function getRemainingTime() constant returns(uint min) {
    if(now < deadline) {
      min = (deadline - now) / (1 minutes);
    }
  }

  // (8) 終了
  function close() onlyOwner {
    // トークンをオーナーに転送
    token.transfer(owner, token.balanceOf(this));
    // コントラクトを破棄(当該コントラクトが保持するETHはオーナーに送金される)
    selfdestruct(owner);
  }
}

