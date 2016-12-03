//
//  LDCSeeBigPictureController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/27.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCSeeBigPictureController.h"
#import "LDCTopicItem.h"

#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>


#import "LDCPhotoManager.h"

@interface LDCSeeBigPictureController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation LDCSeeBigPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    _imageView = imageView;
    
    if (_ldcTopItem.localImage) {
        imageView.image = _ldcTopItem.localImage;
    } else {
    
        [imageView sd_setImageWithURL:[NSURL URLWithString:_ldcTopItem.image0]];
    }
    
    [_scrollView addSubview:imageView];
    
    CGFloat h = LDCScreenW / _ldcTopItem.width * _ldcTopItem.height;
    imageView.frame = CGRectMake(0, 0, LDCScreenW, h);
    
    if (_ldcTopItem.isBigPicture) {
        
        _scrollView.contentSize = CGSizeMake(LDCScreenW, h);
        
        _scrollView.delegate = self;
        
        if (_ldcTopItem.height > h) {
            _scrollView.maximumZoomScale = _ldcTopItem.height / h;
        }
        
    }else {
    
        imageView.center = CGPointMake(LDCScreenW * 0.5, LDCScreenH * 0.5);
    }
    
}
- (IBAction)saveButton:(id)sender {
    
//    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                
                [LDCPhotoManager savePhotoWithImage:_imageView.image albumTitle:@"百思不得姐" completion:^(BOOL success, NSError *error) {
                    if (success) {
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    } else {
                        
                        [SVProgressHUD showErrorWithStatus:@"保存失败"];
                    
                    }
                    
                }];
                
            }
        }];
    }else if (status == PHAuthorizationStatusAuthorized) {
        
    
        [LDCPhotoManager savePhotoWithImage:_imageView.image albumTitle:@"百思不得姐" completion:^(BOOL success, NSError *error) {
            
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            } else {
                
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
            }
            
        }];
        
    } else {
    
        [SVProgressHUD showInfoWithStatus:@"进入设置界面->找到当前应用->打开允许访问相册开关"];
    }
    
}



- (IBAction)backButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
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
