console.log("A" + "B" - 2) NaN
console.log("A" + "B" + 2) AB2
console.log("2" + 2) 22

console.log("2" == 2); true
console.log(undefined == null); true


## NaN

在 JavaScript 中，`NaN` 代表 "Not-a-Number"，是一个特殊的值，用于表示一个非数值的结果。具体来说，`NaN` 通常出现在以下几种情况下：

### 1. 数学运算的结果
- 当某些数学运算的结果不是一个有效的数字时，会返回 `NaN`。
  ```javascript
  console.log(0 / 0); // 输出: NaN
  console.log(Math.sqrt(-1)); // 输出: NaN
  console.log(parseInt("abc")); // 输出: NaN
  ```

### 2. 类型检查
- `NaN` 是一个数字类型，但它并不等于任何值，包括它自己。
  ```javascript
  console.log(NaN === NaN); // 输出: false
  ```

### 3. 检查 `NaN`
- 可以使用 `isNaN()` 函数来检查一个值是否为 `NaN`。注意，`isNaN()` 会尝试将参数转换为数字。
  ```javascript
  console.log(isNaN(NaN)); // 输出: true
  console.log(isNaN("abc")); // 输出: true
  console.log(isNaN(123)); // 输出: false
  ```

- 在 ES6 中，`Number.isNaN()` 更严格，只会返回 `true` 当参数是 `NaN` 时，而不会进行类型转换。
  ```javascript
  console.log(Number.isNaN(NaN)); // 输出: true
  console.log(Number.isNaN("abc")); // 输出: false
  ```

### 总结
`NaN` 是 JavaScript 中用于表示非数值的一个重要概念，了解它的特性和用法对于处理数字和数学运算非常关键。