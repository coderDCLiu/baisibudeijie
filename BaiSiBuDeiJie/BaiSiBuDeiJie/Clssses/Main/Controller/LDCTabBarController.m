//
//  LDCTabBarController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/15.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCTabBarController.h"
#import "LDCNavigationController.h"

#import "LDCEssenceController.h"
#import "LDCNewController.h"
#import "LDCPublishController.h"
#import "LDCFreindTrendController.h"
#import "LDCMeController.h"
#import "XQWriteViewController.h"

#import "UIImage+Render.h"
#import "UIView+Frame.h"


@interface LDCTabBarController ()<UITabBarControllerDelegate>

@property (weak, nonatomic) UIButton *plusBtn;

@property (strong, nonatomic) UIViewController *selectedVC;

@property (nonatomic, strong) XQWriteViewController *writeVC;

@end

@implementation LDCTabBarController

-(UIButton *)plusBtn
{
    if (_plusBtn == nil) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageWithOriginalImage:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageWithOriginalImage:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        _plusBtn = button;
        [self.tabBar addSubview:button];
    }
    return _plusBtn;
}

+(void)load
{
    //设置tabBarItem的字体大小
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    //添加子控制器
    [self addChildController];
    
    //设置UITabBar
    [self setUpTabBar];
    
    //tabBar的渲染颜色
    self.tabBar.tintColor = [UIColor blackColor];
    
    self.plusBtn.center = CGPointMake(self.tabBar.bounds.size.width * 0.5, self.tabBar.bounds.size.height * 0.5);
    
}

//在View显示完毕时, 添加按钮,覆盖在底部按钮之上.
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //创建添加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"btn_card"] forState:UIControlStateNormal];
    CGFloat btnWH = 98;
    //按钮剧中显示
    addBtn.frame = CGRectMake((LDCScreenW - btnWH) * 0.5,-32, btnWH, btnWH);
    [self.tabBar addSubview:addBtn];
    //监听按钮点击
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

//添加按钮点击
- (void)addBtnClick {
    
    XQWriteViewController *writeVC = [[XQWriteViewController alloc] init];
    self.writeVC = writeVC;
    __weak typeof(self) weakSelf = self;
    writeVC.closeTask = ^{
        weakSelf.writeVC = nil;
    };
    [[UIApplication sharedApplication].keyWindow addSubview:writeVC.view];
    
}

#pragma mark - UITabBarControllerDelegate

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (_selectedVC == viewController) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"repeatClickTab" object:nil];
    }
    _selectedVC = viewController;
}

#pragma mark - 添加子控制器
-(void)addChildController
{
   //精华
    LDCEssenceController *ldcEC = [[LDCEssenceController alloc]init];
    LDCNavigationController *ldcNav1 = [[LDCNavigationController alloc]initWithRootViewController:ldcEC];
    [self addChildViewController:ldcNav1];
    
    //新帖
    LDCNewController *ldcNC = [[LDCNewController alloc]init];
    LDCNavigationController *ldcNav2 = [[LDCNavigationController alloc]initWithRootViewController:ldcNC];
    [self addChildViewController:ldcNav2];
    
    //发布
//    LDCPublishController *ldcPC = [[LDCPublishController alloc]init];
//    [self addChildViewController:ldcPC];
    XQWriteViewController *writeVC = [[XQWriteViewController alloc]init];
    [self addChildViewController:writeVC];
//    XQWriteViewController *writeVC = [[XQWriteViewController alloc] init];
    self.writeVC = writeVC;
    __weak typeof(self) weakSelf = self;
    writeVC.closeTask = ^{
        weakSelf.writeVC = nil;
    };
    [[UIApplication sharedApplication].keyWindow addSubview:writeVC.view];
    
    //关注
    LDCFreindTrendController *ldcFTC = [[LDCFreindTrendController alloc]init];
    LDCNavigationController *ldcNav3 = [[LDCNavigationController alloc]initWithRootViewController:ldcFTC];
    [self addChildViewController:ldcNav3];
    
    //我的
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LDCMeController" bundle:nil];
    LDCMeController *ldcMC = [storyboard instantiateInitialViewController];
    LDCNavigationController *ldcNav4 = [[LDCNavigationController alloc]initWithRootViewController:ldcMC];
    [self addChildViewController:ldcNav4];
    
    _selectedVC = self.childViewControllers[0];
}

#pragma mark - 设置UITabBar

-(void)setUpTabBar
{
    //1
    UIViewController *vc1 = self.childViewControllers[0];
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc1.tabBarItem.selectedImage = [UIImage imageWithOriginalImage:@"tabBar_essence_click_icon"];
    vc1.tabBarItem.title = @"精华";
    
    //2
    UIViewController *vc2 = self.childViewControllers[1];
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc2.tabBarItem.selectedImage = [UIImage imageWithOriginalImage:@"tabBar_new_click_icon"];
    vc2.tabBarItem.title = @"新帖";
    
    //3
    UIViewController *vc3 = self.childViewControllers[2];
    vc3.tabBarItem.enabled = NO;

   
    //4
    UIViewController *vc4 = self.childViewControllers[3];
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc4.tabBarItem.selectedImage = [UIImage imageWithOriginalImage:@"tabBar_friendTrends_click_icon"];
    vc4.tabBarItem.title = @"关注";

    //5
    UIViewController *vc5 = self.childViewControllers[4];
    vc5.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc5.tabBarItem.selectedImage = [UIImage imageWithOriginalImage:@"tabBar_me_click_icon"];
    vc5.tabBarItem.title = @"我";

    

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
