//
//  AFHTTPSessionManager+Manager.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/18.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "AFHTTPSessionManager+Manager.h"

@implementation AFHTTPSessionManager (Manager)

+(instancetype)ldc_manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    manager.responseSerializer = response;
    
    return manager;
}

@end
