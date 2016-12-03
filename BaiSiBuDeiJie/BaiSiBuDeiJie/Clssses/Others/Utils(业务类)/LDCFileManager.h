//
//  LDCFileManager.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/24.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDCFileManager : NSObject

+(void)getFileSizeWithDirectory:(NSString*)directoryPath completion:(void(^)(int))completion;

+(void)getFileSizeStringWithDirectory:(NSString*)directoryPath completion:(void(^)(NSString*))completionString;

+(void)removeDirectoryFileWithDirectory:(NSString*)directoryPath;

@end
