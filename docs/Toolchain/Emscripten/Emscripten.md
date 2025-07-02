# Emscripten 介绍

## 环境

```shell
## guide:https://emscripten.org/docs/getting_started/downloads.html
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk 
.\emsdk install latest
.\emsdk activate latest
.\emsdk_env.bat 
emcc -v

```

## 使用
```shell
### 每次使用都需要激活一下
./emsdk activate latest # or ./emsdk activate 1.38.45
source ./emsdk_env.sh 
#单个文件
emcc test/hello_world.c  -o xxx/xx.html
emcc test/hello_world.cpp  -o xxx/xx.html  


## 也可以用nodejs 来运行生成之后的.js,但是发现复杂的可能不支持
node hello_world.js 


### io读取
emcc test/hello_world_file.cpp -o hello.html --preload-file test/hello_world_file.txt


```

## 工作原理与流程
emscripten的工作原理主要包括以下几个步骤:

1.编译前处理:

将C/C++源代码预处理,展开宏定义和头文件。
对代码进行静态分析,生成中间表示(IR)。

2.LLVM编译:

将中间表示(IR)转换为LLVM字节码。
执行LLVM的优化pass,对代码进行优化。
WebAssembly或asm.js生成:

将优化后的LLVM字节码转换为WebAssembly或asm.js格式。
在此过程中,emscripten会插入JavaScript桥接代码,用于与浏览器环境交互。

3. 运行时库:

生成一个运行时库,提供对C/C++标准库和其他常用库的支持。
这些库会被打包到最终的输出文件中。


4.输出部署:

将生成的WebAssembly或asm.js文件,以及运行时库文件一起部署到Web服务器上。
在Web页面中引用这些文件,即可在浏览器中运行C/C++程序。


通过这样的工作流程,emscripten可以将C/C++代码高效地编译为在Web浏览器上运行的代码。这种方式使得开发者可以重用现有的C/C++代码,同时也充分利用了浏览器的性能和功能。


## 仓库介绍
这个是源码仓库，可以阅读源代码；允许开发者深入地修改和扩展 Emscripten 编译器的功能；修改完可以生成 emsdk
https://github.com/emscripten-core/emscripten.git 

二进制文件，可以方便自己直接使用
emsdk 提供了跨平台的安装和管理脚本,使得 Emscripten 的设置和更新变得很方便。
https://github.com/emscripten-core/emsdk.git


### 使用资料
https://cloud.tencent.com/developer/news/690454
https://emscripten.org/docs/getting_started/Tutorial.html