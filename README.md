# FJTabBarController
自定义中间凸起tabBar+侧滑功能

>
>一款自定义中间凸起tabBar+全屏侧滑功能的控件，通过KVC的方式自定义中间凸起tabBar，通过父子控制器实现全屏侧滑，加入的手势与系统侧滑手势不冲突
>

![效果图](https://github.com/nuanqing/FJTabBarController/blob/master/cehua.gif)

基本使用
--------
AppDelegate中设置:
```
FJLeftViewController *leftVC=[[FJLeftViewController alloc]init];
//可以加导航，也可以不加
FJNavgationViewController *leftNVC = [[FJNavgationViewController alloc]initWithRootViewController:leftVC];
FJTabBarViewController *tabBarVC =[[FJTabBarViewController alloc]init];
FJMainViewController *mvc = [[FJMainViewController alloc]initWithLeftVC:leftNVC mainVC:tabBarVC];
self.window.rootViewController = mvc;
```
其它地方可自行修改
