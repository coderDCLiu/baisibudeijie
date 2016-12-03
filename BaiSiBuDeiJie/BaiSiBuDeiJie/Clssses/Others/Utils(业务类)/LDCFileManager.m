//
//  LDCFileManager.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/24.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCFileManager.h"

@implementation LDCFileManager

+(void)getFileSizeWithDirectory:(NSString *)directoryPath completion:(void(^)(int ))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        BOOL isDirectory = NO;
        BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        if (!isExists || !isDirectory) {
            
            @throw [NSException exceptionWithName:@"FilePathError" reason:@"文件路径错误!" userInfo:nil];
        }
        
        
        NSArray *subpaths = [mgr subpathsAtPath:directoryPath];
        
        int  totalSize = 0;
        
        
        for (NSString *subPath in subpaths) {
            
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            if ([filePath containsString:@".DS"]) continue;
            
            
            BOOL isDirectory = NO;
            BOOL isExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExists || isDirectory) continue;
            
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            
            totalSize += [attr fileSize];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
            
        });

    });
 
}

+(void)getFileSizeStringWithDirectory:(NSString *)directoryPath completion:(void(^)(NSString*))completionString
{
    [LDCFileManager getFileSizeWithDirectory:directoryPath completion:^(int totalSize) {
        
        NSUInteger fileSize = totalSize;
        
        CGFloat file ;
        
        NSString *fileStr = nil;
        
        if (fileSize > 1000 *1000) {
            file = fileSize / 1000.0 / 1000.0;
            fileStr = [NSString stringWithFormat:@"%.1fMB",file];
        } else if (fileSize > 1000){
            file = fileSize / 1000.0;
            fileStr = [NSString stringWithFormat:@"%.1fKB",file];
        } else if (fileSize > 0) {
            fileStr = [NSString stringWithFormat:@"%ldB",fileSize];
        }
        
        fileStr = [fileStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
        if (completionString) {
            completionString (fileStr);
        }
        
    }];
    

}

+(void)removeDirectoryFileWithDirectory:(NSString *)directoryPath
{
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExists || !isDirectory) {
        
        @throw [NSException exceptionWithName:@"FilePathError" reason:@"文件路径错误!" userInfo:nil];
    }
    
    [[NSFileManager defaultManager]removeItemAtPath:directoryPath error:nil];
    [[NSFileManager defaultManager]createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
}

@end
