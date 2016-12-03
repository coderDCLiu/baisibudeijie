//
//  LDCEssenceController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/15.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCEssenceController.h"

#import "LDCAllController.h"
#import "LDCPictureController.h"
#import "LDCVideoController.h"
#import "LDCVoiceController.h"
#import "LDCTextController.h"


@interface LDCEssenceController ()


@end

@implementation LDCEssenceController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航条上的按钮
    [self setUpBarButton];
    
    //为控制器添加子控制器
    [self setUpChildController];
    
}

//为控制器添加子控制器
-(void)setUpChildController
{
    //全部
    LDCAllController *ldcAllC = [[LDCAllController alloc]init];
    ldcAllC.title = @"全部";
    [self addChildViewController:ldcAllC];
    
    //视频
    LDCVideoController *ldcVideoC = [[LDCVideoController alloc]init];
    ldcVideoC.title = @"视频";
    [self addChildViewController:ldcVideoC];
    
    //声音
    LDCVoiceController *ldcVoiceC = [[LDCVoiceController alloc]init];
    ldcVoiceC.title = @"声音";
    [self addChildViewController:ldcVoiceC];
    
    //图片
    LDCPictureController *ldcPictureC = [[LDCPictureController alloc]init];
    ldcPictureC.title = @"图片";
    [self addChildViewController:ldcPictureC];
    
    //段子
    LDCTextController *ldcTextC = [[LDCTextController alloc]init];
    ldcTextC.title = @"段子";
    [self addChildViewController:ldcTextC];
    
}

//设置导航条上的按钮
-(void)setUpBarButton
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] hightLightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(gameClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] hightLightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(randomClick)];
}
//导航条上左边游戏按钮的点击
-(void)gameClick
{
    NSLog(@"gameClick");
}
//导航条上右边随机按钮的点击
-(void)randomClick
{
    NSLog(@"randomClick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
