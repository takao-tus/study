#Ethereum
##Ethereumのプライベート環境構築
mac
    brew tap ethereum/ethereum
    brew install ethereum

linux
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
