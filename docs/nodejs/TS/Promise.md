Promise 主要有三种状态：

### 1. **Pending（待定）**
- 初始状态，表示 Promise 仍在进行中，尚未完成或拒绝。

### 2. **Fulfilled（已完成）**
- 表示 Promise 已成功完成，且有一个结果值。此时，`then()` 方法的回调会被调用。

### 3. **Rejected（已拒绝）**
- 表示 Promise 已被拒绝，且有一个原因（错误信息）。此时，`catch()` 方法的回调会被调用。

### 状态转换
- **从 Pending 到 Fulfilled**：当异步操作成功时，调用 `resolve()` 方法，Promise 状态变为 Fulfilled。
- **从 Pending 到 Rejected**：当异步操作失败时，调用 `reject()` 方法，Promise 状态变为 Rejected。

### 注意
- 一旦 Promise 的状态从 Pending 转换为 Fulfilled 或 Rejected，就无法再改变状态。
- 这保证了 Promise 的不可变性，使得异步操作的结果可以被安全地处理。

### 总结
Promise 有三种状态：Pending、Fulfilled 和 Rejected，分别表示异步操作的进行中、成功和失败。