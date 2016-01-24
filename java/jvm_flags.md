# Java Virtual Machine Flags

* 基本参数

```bash
-Xmsn 指定jvm堆的初始大小，默认为物理内存的1/64，最小为1M；可以指定单位，比如k、m，若不指定，则默认为字节; 
-Xmxn 指定jvm堆的最大值，默认为物理内存的1/4或者1G，最小为2M；单位与-Xms一致;
-Xmn  Young Generation的Heap大小;
-Xss  每个线程的Stack大小;
-Xoss 本地方法栈大小;
-XX:PermSize=10M 方法区最小内存(HotSpot永久代)
-XX:MaxPermSize=10M 方法区最大内存(HotSpot永久代)
-XX:MaxDirectMemorySize=10M 最大直接内存大小

-Xnoclassgc 关掉永久代class回收
-verbose:class(Product版本的JVM中使用)
-XX:+TraceClassLoading(Product版本的JVM中使用)
-XX:+TraceClassUnLoading(fastdebug版本的JVM中使用)

-XX:+HeapDumpOnOutOfMemoryError(开启内存溢出时dump堆文件)
-XX:HeapDumpPath=(定义dump文件路径)
-XX:+TraceClassLoading 开启类加载调试
-XX:-verify:none 关闭大部分的类验证措施
```

* GC

```bash
UseSerialGC: 虚拟机运行在Client 模式下的默认值，打开此开关后，使用Serial +
			 Serial Old 的收集器组合进行内存回收

UseParNewGC: 打开此开关后，使用ParNew + Serial Old 的收集器组合进行内存回收

UseConcMarkSweepGC: 打开此开关后，使用ParNew + CMS + Serial Old 的收集器组合进行内存
					回收。Serial Old 收集器将作为CMS 收集器出现Concurrent Mode Failure失败后的后备收集器使用
UseParallelGC: 虚拟机运行在Server 模式下的默认值，打开此开关后，使用Parallel
			   Scavenge + Serial Old（PS MarkSweep）的收集器组合进行内存回收

UseParallelOldGC: 打开此开关后，使用Parallel Scavenge + Parallel Old 的收集器组合进行内存回收
 				  SurvivorRatio	  新生代中Eden 区域与Survivor 区域的容量比值， 默认为8， 代表
				  Eden ：Survivor=8∶1

PretenureSizeThreshold: 直接晋升到老年代的对象大小，设置这个参数后，大于这个参数的对象将直接在老年代分配

MaxTenuringThreshold: 晋升到老年代的对象年龄。每个对象在坚持过一次Minor GC 之后，年
					      龄就加1，当超过这个参数值时就进入老年代

UseAdaptiveSizePolicy: 动态调整Java 堆中各个区域的大小以及进入老年代的年龄

HandlePromotionFailure: 是否允许分配担保失败，即老年代的剩余空间不足以应付新生代的整个
						Eden 和Survivor 区的所有对象都存活的极端情况
ParallelGCThreads: 设置并行GC 时进行内存回收的线程数

GCTimeRatio: GC 时间占总时间的比率，默认值为99，即允许1% 的GC 时间。仅在使用Parallel Scavenge 收集器时生效

MaxGCPauseMillis: 设置GC 的最大停顿时间。仅在使用Parallel Scavenge 收集器时生效

CMSInitiatingOccupancyFraction: 设置CMS 收集器在老年代空间被使用多少后触发垃圾收集。默认值为68%，仅在使用CMS 收集器时生效

UseCMSCompactAtFullCollection: 设置CMS 收集器在完成垃圾收集后是否要进行一次内存碎片整理。仅在使用CMS 收集器时生效

CMSFullGCsBeforeCompaction: 设置CMS 收集器在进行若干次垃圾收集后再启动一次内存碎片整理。
							仅在使用CMS 收集器时生效

-XX:+PrintGCDetails 开启打印GC收集信息, 并在进程退出时打印各区分配情况
```

* Compile 

```bash
-Xint 强制解释模式
-Xcomp 强制"编译模式"
-XX:+TieredCompilation 开启分层策略编译
-XX:CompileThreshold 设置方法调用计数器阈值
-XX:-UseCounterDecay关闭热度衰减, 
-XX:CounterHalfLifeTime设置半衰周期时间, 秒)
-XX：BackEdgeThreshold设置回边计数器阈值
-XX:OnStackReplacePercentage(栈上替换比例)
-XX：-BackgroundCompilation 禁止后台编译
-XX:+UnlockDiagnosticVMOptions 解锁调试DebugVM
-XX:+PrintCompilation 打印编译信息
-XX:+PrintInlining 打印内联信息
-XX:+PrintAssembly 打印反汇编信息, 须hsdis插件, 放在jre/bin/client或jre/bin/server下
(以下2个须debug版本jdk)
-XX:+PrintCFGToFlie (C1 将编译数据打印到文件)
-XX:+PrintIdealGraphFile(C2 将编译数据打印到文件)
-XX:CompileCommand=dontinline,*Bar.sum 不内联
-XX:CompileCommand=compileonly,*Bar.sum 只编译
```
