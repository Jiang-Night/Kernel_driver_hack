# Kernel_driver_hack
>Android/Linux Kernel dirver read and write  memory.
> linux kernel read/write process memory

##### ~~暂时无法读取bss段内存~~

注意：未实现多物理页页读，读取内存过长时会出现错误

使用相应型号的内核源码编译驱动文件

使用`insmod xxx`命令即可加载驱动

使用`rmmod xxx`命令即可卸载驱动

使用`dmesg`查看驱动日志
