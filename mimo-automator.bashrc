###########################################################################################
#        .__                                __                         __                 #
#  _____ |__| _____   ____   _____   __ ___/  |_  ____   _____ _____ _/  |_  ___________  #
# /     \|  |/     \ /  _ \  \__  \ |  |  \   __\/  _ \ /     \\__  \\   __\/  _ \_  __ \ #
#|  Y Y  \  |  Y Y  (  <_> )  / __ \|  |  /|  | (  <_> )  Y Y  \/ __ \|  | (  <_> )  | \/ #
#|__|_|  /__|__|_|  /\____/  (____  /____/ |__|  \____/|__|_|  (____  /__|  \____/|__|    #
#      \/         \/              \/                         \/     \/                    #
###########################################################################################

# return now + 1 min (default in mimo app)
# input: none
# output: time in hex (uint256)
function deadline() {
  ts=`date +"%s"`
  printf "%064x\n" `expr $ts + 60`
}

# decimal to hex conversion in bigint
# input: number in decimal
# output: number in hex (uint256)
function dec2hex() {
  echo "ibase=A;obase=16;$1" | bc | xargs -0 -I h printf "%065s" h
}

# hex to decimal conversion in bigint
# input: number in hex (uint256)
# output: number in decimal
function hex2dec() {
  uppercase=`echo $1 | tr a-z A-Z`
  echo "ibase=16;obase=A;$uppercase" | bc
}

# input:
#    1 - exchange -  address for token pair exchange
#    2 - amount - iotx amount (in decimal)
# output - display contract read result
function getIotxToTokenInputPrice() {
  exchange=$1
  amount=`dec2hex $2`
  hex2dec `ioctl action read $exchange -b a46f9389${amount}`
}

# input:
#    1 - exchange -  address for token pair exchange
#    2 - amount - token amount (decimal)
# output - display contract read result
function getTokenToIotxInputPrice() {
  exchange=$1
  amount=`dec2hex $2`
  hex2dec `ioctl action read $exchange -b d458a2d1${amount}`
}

# input:
#    1 - exchange -  address for token pair exchange
#    2 - token_sold - amount of token to be sold
#    3 - min_iotx - minimum amount of coin in *RAU* to buy
# output - none
function tokenToIotxSwapInput() {
  exchange=$1
  token_sold=`dec2hex $2`
  min_iotx=`dec2hex $3`
  dl=`deadline`
  ioctl contract invoke bytecode $exchange 10dc202f${token_sold}${min_iotx}${dl}
}

# input:
#    1 - exchange -  address for token pair exchange
#    2 - iotx_sold - amount of coin in IOTX to sell
#    3 - min_token - minimum amount of token to buy
# output - none
function iotxToTokenSwapInput() {
  exchange=$1
  iotx_sold=$2
  min_token=`dec2hex $3`
  dl=`deadline`
  ioctl contract invoke bytecode $exchange eecd096a${min_token}${dl} ${iotx_sold}
}

# input:
#    1 - exchange address for token pair exchange
#    2 - min-liquidity to get (in decimal)
#    3 - max-tokens to spend (in decimal)
#    4 - iotx amount to spend (in decimal)
# output - none
function addLiquidity() {
  exchange=$1
  min_liquidity=`dec2hex $2`
  max_tokens=`dec2hex $3`
  iotx_amount=$4
  dl=`deadline`
  ioctl contract invoke bytecode $exchange 422f1043${min_liquidity}${max_tokens}${dl} ${iotx_amount}
}

# input:
#    1 - exchange address for token pair exchange
#    2 - amount - liquidity to remove (in decimal)
#    3 - min-iotx (in decimal)
#    4 - minimum_tokens
# output - none
function removeLiquidity() {
  exchange=$1
  amount=`dec2hex $2`
  min_iotx=`dec2hex $3`
  min_tokens=`dec2hex $4`
  dl=`deadline`
  ioctl contract invoke bytecode $exchange f88bf15a${amount}${min_iotx}${min_tokens}${dl}
}
