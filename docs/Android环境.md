## cocos2dx Android 

### 前期准备
1. ndk：android-ndk-r16b 
    设置系统环境变量：  
    1.NDK_ROOT 为 android-ndk-r16b目录  
    2.Path增加： %NDK_ROOT%

    下载地址：https://dl.google.com/android/repository/android-ndk-r16b-windows-x86_64.zip  

2. Android Studio:Android Studio Jellyfish | 2023.3.1  

3. sdk:可直接使用Android Studio 下载：Tools->SDK Manager  

------



### 生成动态库：so 文件
如无C++ 代码层修改，可不用生成
```shell
cd 项目目录\client\frameworks\runtime-src
build_native.bat
```

------



### Android 应用生成

使用Android Studio 编译运行即可  
或使用命令行  
```shell
  .\gradlew.bat assembleRelease
```

------



### Gradle 版本：

工程已配置，仅做记录使用  
Gradle Plugin Version:4.1.1
Gradle Version:6.7.1


### test

