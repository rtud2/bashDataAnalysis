@namespace "bits"
# collection of functions to deal with binary
#
function bitflip(b){
if(b == ""){
return ""
}
return((substr(b, 1, 1) == 0 ? 1 : 0) bitflip(substr(b, 2)))
}

function dec2bin(d, b){
while(d){
b = (d%2 b)
d = int(d/2)
}
print b ? b : 0
}

function bin2dec(b){
pow = length(b) - 1;
if(b == ""){
return ""
}
return(substr(b, 1, 1)*(2^pow) + bin2dec(substr(b, 2)))
}

function rev(str){
if(str == ""){
return ""
}
return(rev(substr(str, 2)) substr(str, 1, 1))
}

function add1bit(b){
revb = rev(b);
first0 = index(revb, "0")
val = (bitflip(substr(revb, 1, first0)) substr(revb, first0+1)
return rev(val);
}

function twoscomp(b){
# b is a binary string with leading value indicating +/-
pow = length(b)-1
msb = substr(b, 1, 1)
lsbs = substr(b, 2)
return  -msb * (2^pow) + bin2dec(lsbs)
}

function bin2float(b){
#expect a 32 bit float
# return float number
if(length(b) != 32){
print "binary expected to be length 32. b is length:", length(b)
exit
}
sign = substr(b, 1, 1) == 1
exponent= bin2dec(substr(b, 2, 8))
fraction = 1 + frac2dec_rev(rev(substr(b, 10)))
val = 2^(exponent - 127) * fraction
return(sign ? -val : val)
}

function frac2dec_rev(b){
# convert fractional component of float to decimal
# input 22 bits and reversed so bit 1 is first, bit 22 is last
pow = length(b)
if(b == ""){
return ""
}
return(substr(b, 1, 1)*(2^(-pow)) + frac2dec_rev(substr(b,2)))
}


function pad0(b){
# pad binary until it's got 16 bit with
if (length(b) >= 16){
return(b)
}
return(pad0(0b))
}
