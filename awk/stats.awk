@namespace "stats"
# Collection of functions to deal with statistics
#

function min(arr){
asort(arr)
return(arr[1])
}

function max(arr){
asort(arr)
n = length(arr)
return(arr[n])
}

function median(arr){
asort(arr)
n = length(arr)
medIdx = (n % 2 == 0 ? n/2 : int(n/2) + 1)
medianVal = (n % 2 == 0 ? (arr[medIdx] + arr[medIdx + 1])/2 : arr[medIdx])
return(medianVal)
}

function sum(arr){
val = 0;
for(i in arr){
val += arr[i]
}
return(val)
}

function mean(arr){
n = length(arr)
return(sum(arr)/n)
} 

function head(){
	# print out field values and field numbers
	column = sprintf("column -s%s -t", FS)
	print "Name", "FieldNumber";
	for(i = 1; i <= NF; i++){
		print $i, i | column;
		}
	}
