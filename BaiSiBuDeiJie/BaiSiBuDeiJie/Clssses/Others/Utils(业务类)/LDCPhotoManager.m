//
//  LDCPhotoManager.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/29.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCPhotoManager.h"
#import <Photos/Photos.h>

@implementation LDCPhotoManager

#pragma mark - 保存图片

+(void)savePhotoWithImage:(UIImage*)image albumTitle:(NSString*)title completion:(void(^)(BOOL success , NSError *error))completion
{

    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        PHAssetCollection *assetCollection = [self fetchAssetColletion:title];
        
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest = nil;
        
        if (assetCollection) {
            
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else {
            
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
        }
        
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
        
        [assetCollectionChangeRequest addAssets:@[placeholder]];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        if (completion) {
            completion(success,error);
        }
        
    }];
}

#pragma mark - 获取之前的相册

+(PHAssetCollection*)fetchAssetColletion:(NSString *)albumTitle
{
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *asset in result) {
        
        if ([asset.localizedTitle isEqualToString:albumTitle]) {
            return asset;
        }
    }

    return nil;
}



@end
