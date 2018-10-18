pragma solidity ^0.4.8;
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