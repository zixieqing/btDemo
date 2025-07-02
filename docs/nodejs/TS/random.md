```javascript
// 概率分布
var random = function(arr, perArr){
    var randomNum = Math.random()
    console.log(randomNum)
    var nextRange = 0
    var preRange = 0
    for(index = 0; index < perArr.length; index++){
        var itemPer = perArr[index] / 100
        nextRange = nextRange + itemPer
        console.log("itemPer,nextRange, preRange",itemPer, nextRange, preRange)
        if (randomNum >= preRange && randomNum < nextRange){
            return arr[index]
        }
        preRange = nextRange;
    }
}
console.log(random([22,33,44,55], [30,40,20,10]))

```


```javascript
//最大非重复串长度
var getMaxCharLen = function(str){
    console.log(str.split(''))
    var spArr = str.split('')
    var maxLen = 0
    var saveLen = 0
    for(index= 0; index < spArr.length; index++){
        if (spArr[index] != spArr[index+1]){
            maxLen = maxLen + 1
        }else{
           if(maxLen > saveLen){
               saveLen = maxLen;
           }
           maxLen = 0;
        }
    } 
    return saveLen == 0 ? maxLen : saveLen
    
}
console.log(getMaxCharLen("abcddefgxzubbbbcccc"))


```