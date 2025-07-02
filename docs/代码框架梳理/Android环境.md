## cocos2dx Android 

### 前期准备
ndk：android-ndk-r16b 
    设置系统环境变量：NDK_ROOT
    下载地址：https://dl.google.com/android/repository/android-ndk-r16-windows-x86_64.zip

AndroidStudio:Android Studio Jellyfish | 2023.3.1
sdk:可直接使用Android Studio 下载：Tools->SDK Manager


### 生成动态库：so 文件
如无C++ 代码层修改，可不用生成
```shell
cd 项目目录\client\frameworks\runtime-src
build_native.bat
```

### Android 应用生成
使用Android Studio 编译运行即可




