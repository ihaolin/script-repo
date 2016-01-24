# 制作Mac OSX 启动U盘
	
+ 可从APP Store下载或第三方系统DMG文件, 格式化U盘，使用自带的**Disk Utils**
+ 截图
	![format usb](http://ips.chotee.com/wp-content/uploads/2014/osx-yosemite-usb-install-drive/format-usb.jpg)
+ 在【选项】里选择**GUID**
	![GUID](http://ips.chotee.com/wp-content/uploads/2014/osx-yosemite-usb-install-drive/guid.jpg)
+ 使用以下命令，将系统写到U盘(务必确保Yosemite.app存在)
	
	```bash
	sudo /Applications/Install\ OS\ X\ Yosemite.app/Contents/Resources/createinstallmedia --volume /Volumes/iPlaySoft --applicationpath /Applications/Install\ OS\ X\ Yosemite.app --nointeraction
	```
	
+ 等待，直到
	
	```bash
	Erasing Disk: 0%... 10%... 20%... 30%...100%...
Copying installer files to disk...
Copy complete.
Making disk bootable...
Copying boot files...
Copy complete.
Done.
	```
	
+ 重启电脑，按住ALT，选择U盘启动，安装系统。