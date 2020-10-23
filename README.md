# Description: The ChainBridge server fails when trying to transfer Eth->Sub

|Files||
|-----|--|
|Dockerfile.geth|based on image chainsafe/chainbridge-geth:20200505131100-5586a65|
|geth.sh|entrypoint for the geth container (will be installed automatically)|
|show-balance|cb-sol-cli command to check a balance (will be installed automatically)|
|transfer-charlie|cb-sol-cli command to initiate a transfer Eth->Sub (will be installed automatically)|
|Dockerfile.chainbridge||
|chainbridge.sh|entrypoint for the chainbridge container (will be installed automatically)|
|config.json|a config file for the ChainBridge server (will be installed automatically)|

This is minimal setup to reproduce error which I get with following steps:

0. Start in localhost any standard Substrate node, no matter which,
   just to enable the ChainBridge server

1. Start Geth and deploy sols:

       docker stop geth && docker rm --force geth
       docker build --force-rm --file Dockerfile.geth --tag geth .
       docker run --name geth --publish 8545:8545 geth

2. Start the ChainBridge:

       docker stop chainbridge && docker rm --force chainbridge
       docker build --force-rm --file Dockerfile.chainbridge --tag chainbridge .
       docker run --name chainbridge --network host chainbridge

3. Check Geth:

       docker exec geth show-balance
       => [erc20/balance] Account ff93B45308FD417dF303D6515aB04D9e89a750Ca has a balance of 1000000.0

4. Make the transfer:

       docker exec geth transfer-charlie
       => [erc20/deposit] Creating deposit to initiate transfer!
       => Waiting for tx: 0xc3b1be87037c52833efd2e06d9a8abf8cc30562d843dea206fae7e69586d4117...

Result: The ChainBridge container will exit with error messages:

    msg="Starting ChainBridge..."
    msg="Connecting to substrate chain..." chain=sub url=ws://localhost:9944
    msg="Connecting to ethereum chain..." chain=geth url=ws://172.17.0.2:8545
    msg="Started sub chain" system=core
    msg="Started geth chain" system=core
    msg="Polling Blocks..." chain=geth
    msg="Handling fungible deposit event" chain=geth dest=1 nonce=1
    msg="Error Unpacking ERC20 Deposit Record" chain=geth err="abi: cannot marshal in to go slice: offset 1459086564571116054970388985452629756850408476906 would go over slice boundary (len=256)"
    msg="Failed to get events for block" chain=geth block=999 err="abi: cannot marshal in to go slice: offset 1459086564571116054970388985452629756850408476906 would go over slice boundary (len=256)"
