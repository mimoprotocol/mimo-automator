# mimo-automator

## How to use

### Set up your `ioctl`

install ioctl following the instructions: https://docs.iotex.io/developer/get-started/ioctl-install.html

### Create/import your wallet

### Set up default account

```
ioctl config set defaultacc [default account]
```

### Clone the code to your local machine

```
git clone git@github.com:mimoprotocol/mimo-automator.git
```

### Add bashrc to your bash
You can use 
```
. ./mimo-automator.bashrc
```
to source the file so all functions can be used in the current bash session.

If you want to add to your bash and use it in all bash sessions,  you can add the above command to `~/.bashrc` or `~/.bash_profile` depending on your bash setup.

### View price
use `getIotxToTokenInputPrice` or `getTokenToIotxInputPrice` to get the price.
Usage
``` bash
getIotxToTokenInputPrice [exchange address][iotx amount]
getTokenToIotxInputPrice [exchange address][token amount]
```

example:
``` bash
getTokenToIotxInputPrice io1kwtjyq0n4c4nsfn9egffh55dq4n43klz0u77n7 10000
```
return from vita to iotx price with 10000 vita tokens.


### Start trade

```bash
iotxToTokenSwapInput [exchange adddress] [iotx amount] [minimal token to receive]
```
example:
```bash
iotxToTokenSwapInput io1kwtjyq0n4c4nsfn9egffh55dq4n43klz0u77n7 10 100 
```
means use 10 iotx to buy vita with minimal receiving 100 vita or revert transaction.

