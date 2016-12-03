//
//  LDCLoginRegisterController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/21.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCLoginRegisterController.h"
#import "LDCLoginRegisterView.h"

@interface LDCLoginRegisterController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;

@end

@implementation LDCLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建登录的View
    LDCLoginRegisterView *ldcLoginView = [LDCLoginRegisterView ldcLoginView];
    [self.middleView addSubview:ldcLoginView];
    //创建注册的View
    LDCLoginRegisterView *ldcRegister = [LDCLoginRegisterView ldcRegisterView];
    ldcRegister.ldc_x = LDCScreenW;
    [self.middleView addSubview:ldcRegister];
}


- (IBAction)dismissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerClick:(UIButton*)sender {
    
    sender.selected = !sender.selected;
    
    self.leadingConstraint.constant = self.leadingConstraint.constant == 0? -LDCScreenW:0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
-(void)viewDidLayoutSubviews
{
    self.middleView.subviews[0].frame = CGRectMake(0, 0, self.middleView.ldc_width * 0.5, self.middleView.ldc_height);
    self.middleView.subviews[1].frame = CGRectMake(self.middleView.ldc_width * 0.5, 0, self.middleView.ldc_width * 0.5, self.middleView.ldc_height);
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
