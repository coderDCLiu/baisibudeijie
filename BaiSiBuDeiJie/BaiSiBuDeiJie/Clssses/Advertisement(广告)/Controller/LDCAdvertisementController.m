//
//  LDCAdvertisementController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/18.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCAdvertisementController.h"
#import "LDCTabBarController.h"
#import "LDCAdItem.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "AFHTTPSessionManager+Manager.h"


#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface LDCAdvertisementController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *adView;

@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property (strong, nonatomic) LDCAdItem *ldcAdItem;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation LDCAdvertisementController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpLaunchScreen];
    
    [self loadAdData];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    
}

//根据屏幕大小采用不同的启动图片
-(void)setUpLaunchScreen
{
    UIImage *image = nil;
    
    if (iPhone6P) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iPhone6) {
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone5) {
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iPhone4) {
        image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    
    self.imageView.image = image;
}

//发送网络请求获取广告图片
-(void)loadAdData
{

    NSDictionary *dict = @{
                           @"code2":code2
                           };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager ldc_manager];
    
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
//        NSLog(@"###%@###",responseObject);
        
        NSDictionary *adDict = [responseObject[@"ad"]lastObject];
        
        self.ldcAdItem = [LDCAdItem mj_objectWithKeyValues:adDict];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.userInteractionEnabled = YES;
        if (!self.ldcAdItem.w) {
            [self jumpClick:nil];
            return ;
        }
        CGFloat h = LDCScreenW / self.ldcAdItem.w * self.ldcAdItem.h;
        imageView.frame = CGRectMake(0, 0, LDCScreenW, h);
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.ldcAdItem.w_picurl]];
        [self.adView addSubview:imageView];
        
        //为广告视图添加点击跳转功能
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tag)];
        [imageView addGestureRecognizer:tag];
        
//        [responseObject writeToFile:@"/Users/liudongcheng/Desktop/ad.plist"atomically:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"***%@***",error);
        
    }];
    
}

//点击广告进行跳转
-(void)tag
{
    NSURL *url = [NSURL URLWithString:self.ldcAdItem.ori_curl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

//跳过按钮点击
- (IBAction)jumpClick:(id)sender {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
   LDCTabBarController *vc = [[LDCTabBarController alloc]init];
    
    window.rootViewController = vc;
    
    [self.timer invalidate];
    
    self.timer = nil;
}

//定时器调用的方法
-(void)timeChange
{
    static int time = 3;
    
    time -= 1;
    
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%d)",time] forState:UIControlStateNormal];
    
    
//    NSLog(@"%d",time);
    if (time == -1) {
        
        [self jumpClick:nil];
    }

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
