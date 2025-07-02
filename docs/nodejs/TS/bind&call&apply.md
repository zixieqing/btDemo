在 TypeScript（以及 JavaScript）中，`apply`、`bind` 和 `call` 是函数对象的方法，用于改变函数的上下文（即 `this` 的指向）。它们之间的区别如下：

### 1. `call`
- **用法**: `func.call(thisArg, arg1, arg2, ...)`
- **功能**: 立即调用函数，并指定 `this` 的值。
- **参数**: 第一个参数是要绑定的 `this` 值，后面的参数是传递给函数的参数。
- **示例**:
  ```typescript
  function greet(greeting: string) {
    console.log(`${greeting}, ${this.name}`);
  }

  const person = { name: 'Alice' };
  greet.call(person, 'Hello'); // 输出: Hello, Alice
  ```

### 2. `apply`
- **用法**: `func.apply(thisArg, [argsArray])`
- **功能**: 立即调用函数，并指定 `this` 的值，参数以数组的形式传入。
- **参数**: 第一个参数是要绑定的 `this` 值，第二个参数是一个数组或类数组对象，包含要传递给函数的参数。
- **示例**:
  ```typescript
  function greet(greeting: string, punctuation: string) {
    console.log(`${greeting}, ${this.name}${punctuation}`);
  }

  const person = { name: 'Alice' };
  greet.apply(person, ['Hi', '!']); // 输出: Hi, Alice!
  ```

### 3. `bind`
- **用法**: `const newFunc = func.bind(thisArg, arg1, arg2, ...)`
- **功能**: 返回一个新函数，并将 `this` 的值绑定到指定的对象。可以提前指定部分参数。
- **参数**: 第一个参数是要绑定的 `this` 值，后面的参数是预设的参数。
- **示例**:
  ```typescript
  function greet(greeting: string) {
    console.log(`${greeting}, ${this.name}`);
  }

  const person = { name: 'Alice' };
  const greetAlice = greet.bind(person);
  greetAlice('Hey'); // 输出: Hey, Alice
  ```

### 总结
- **调用方式**: `call` 和 `apply` 立即调用函数，而 `bind` 返回一个新的函数。
- **参数传递**: `call` 接受参数列表，`apply` 接受一个参数数组，`bind` 可以预设部分参数并返回新函数。

这些方法在处理函数的上下文时非常有用，尤其是在事件处理和回调函数中。