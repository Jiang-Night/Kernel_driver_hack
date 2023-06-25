# Kernel_driver_hack
> Android/Linux Kernel dirver read and write  memory.

##### ~~暂时无法读取bss段内存~~

##### ~~读取内存过长时会出现错误~~

使用相应型号的内核源码编译驱动文件

使用`insmod xxx`命令即可加载驱动

使用`rmmod xxx`命令即可卸载驱动

使用`dmesg`查看驱动日志

Google官方编译内核教程(只提供GKI内核编译)：`https://source.android.com/docs/setup/build/building-kernels?hl=zh-cn`

现已在telegram中发现号称`小迷糊` `雪花`等群聊，滥用本项目模块，做各种游戏辅助外挂，并且一部分工作室拿本项目源码去收费，以及出现'wanbai`开源模块 皆是复制本项目源码以作者的名号到处宣传 本作者只有一个名字：`JiagNight`，共创者`Rogo`项目地址:https://github.com/rogxo/kernel_hack。
请勿拿本项目用作非法用途或商用，本项目开源仅供学习交流，并且源码写的比较烂，还希望各位大佬提交fork优化本驱动模块
