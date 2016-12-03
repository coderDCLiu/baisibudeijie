//
//  LDCPhotoManager.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/29.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDCPhotoManager : NSObject

+(void)savePhotoWithImage:(UIImage*)image albumTitle:(NSString*)title completion:(void(^)(BOOL success, NSError *))completion;


@end
