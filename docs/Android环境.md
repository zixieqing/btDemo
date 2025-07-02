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


### 快速调试android 中的lua 代码
将device.writablePath 相关搜索路径改为外部存储目录 /storage/emulated/0/Android/data/com.yofi.tl/

将对应文件adb push 进去
adb shell 
cd /storage/emulated/0/Android/data/
mkdir com.yofi.tl



adb push D:\forkGit\client\tl-client\win32\res\emag.pk /storage/emulated/0/Android/data/com.yofi.tl/win32/res/
adb push D:\forkGit\client\tl-client\res\edoc.pk /storage/emulated/0/Android/data/com.yofi.tl/res




### Android data/user/0 和 data/app/.base.apk 为什么分别这两个目录加载地图资源，明显data/app/base.apk 要慢很多
 - /data/user/0/<包名>/	用户应用的私有数据目录，存放应用的私有文件、数据库、缓存等。
 - /data/app/<包名>-<随机字符>.apk	应用的 APK 文件所在位置，存放应用的安装包。

- a. 资源存取方式
data/user/0 目录：通常存放应用的私有数据，比如数据库、配置文件等。访问这些文件相对较快，因为它们是普通的文件系统操作。
base.apk 文件：这是应用的安装包，存储在 APK 文件中。加载地图资源（如图像、配置文件）通常需要从 APK 中解压或映射资源。
- b. 文件系统和存储类型
APK 文件：通常存储在设备的 /data/app/ 目录下，属于压缩包或特殊的存储格式。访问时需要进行解压或映射，导致读取速度较慢。
私有目录：文件已经解压到文件系统中，直接访问，速度较快。
- c. 资源加载流程
data/user/0/：资源可以直接以文件的形式读取，速度较快。
base.apk：需要通过 AssetManager 或类似机制加载资源，涉及到解压和解析，耗时较长


