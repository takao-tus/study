#Ethereum

##Ethereumのプライベート環境構築

mac版

    brew tap ethereum/ethereum
    brew install ethereum

linux版

go 入れる必要あり（1.7推奨）

    wget https://storage.googleapis.com/golang/go1.7.linux-armv6l.tar.gz
    
解凍

    sudo tar -C /usr/local -xzf go1.7.linux-armv6l.tar.gz
パス入れる

    vim ~/.bashrc

文末に追加

    export PATH=$PATH:/usr/local/go/bin

パスを反映


    source .bashrc

geth install

    wget https://gethstore.blob.core.windows.net/builds/geth-linux-arm7-1.8.14-316fc7ec.tar.gz
    sudo tar -C /usr/local -xzf geth-linux-arm7-1.8.14-316fc7ec.tar.gz
    sudo ln -s /usr/local/geth-linux-arm7-1.8.14-316fc7ec /usr/local/geth

参考<https://qiita.com/umidachi/items/1be8262e41cb32cab369>

##Ethereumプライベートネット立ち上げ
フォルダを作る
    mkdir privatenet
    cd privatenet

genesis.jsを作る
    {
        "config": {
            "chainId": 65000,
            "homesteadBlock": 0,
            "eip155Block": 0,
            "eip158Block": 0
        },
        "alloc"      : {},
        "coinbase"   : "0x0000000000000000000000000000000000000000",
        "difficulty" : "0x20000",
        "extraData"  : "",
        "gasLimit"   : "0x2fefd8",
        "nonce"      : "0x0000000000000042",
        "mixhash"    : "0x0000000000000000000000000000000000000000000000000000000000000000",
        "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000",
        "timestamp"  : "0x00"
    }

