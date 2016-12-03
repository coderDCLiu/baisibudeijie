//
//  LDCNavigationController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/15.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCNavigationController.h"
#import "LDCNavigationBar.h"
#import "LDCBackView.h"

@interface LDCNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LDCNavigationController

+(void)load
{
    //拿到当前类下面的 UINavigationBar 设置背景图片和文字大小
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    bar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //使用自定义的导航条
    LDCNavigationBar *bar = [[LDCNavigationBar alloc]initWithFrame:self.navigationBar.frame];
    
    [self setValue:bar forKey:@"navigationBar"];
    
    //设置手势代理
//    self.interactivePopGestureRecognizer.delegate = self;
    
    //打印self.interactivePopGestureRecognizer
//    NSLog(@"%@",self.interactivePopGestureRecognizer);
    //打印的输出结果
    //<UIScreenEdgePanGestureRecognizer: 0x7f96b583ee30; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7f96b583bd50>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7f96b583e8d0>)>>
    
    //去掉系统的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    //拿到系统手势的代理
    id target = self.interactivePopGestureRecognizer.delegate;
    
    //创建手势,添加到导航控制器的view上面,并且调用系统手势代理的目标方法,实现全局滑动的返回功能
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];;
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
}


//调用代理方法,使得push后的控制器有边缘滑动返回功能
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

//设置导航条上的返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        
        LDCBackView *backView = [LDCBackView backViewWithImage:[UIImage imageNamed:@"navigationButtonReturn"] hightLightImage:[UIImage imageNamed:@"navigationButtonReturnClick"] title:@"返回" target:self action:@selector(back)];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backView];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];
}

//返回按钮的点击
-(void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
