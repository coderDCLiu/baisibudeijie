//
//  LDCStatusWindow.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 2016/11/1.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCStatusWindow.h"

@implementation LDCStatusWindow

static LDCStatusWindow *_window;

+(void)show
{
    LDCStatusWindow *window = [[LDCStatusWindow alloc]init];
    window.rootViewController = [[UIViewController alloc]init];
    window.backgroundColor = [UIColor clearColor];
    window.frame = CGRectMake(0, 0, LDCScreenW, 20);
    window.windowLevel = UIWindowLevelAlert;
    window.hidden = NO;
    _window = window;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"点击状态栏");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"statusClick" object:nil];
}
@end
