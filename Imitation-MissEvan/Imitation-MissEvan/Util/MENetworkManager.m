//
//  MENetworkManager.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 17/1/2.
//  Copyright © 2017年 xkl. All rights reserved.
//

#import "MENetworkManager.h"
#import "MEHeader.h"

@implementation MENetworkManager

+ (void)downFromServerWithSoundUrl:(NSURL *)url progress:(void (^)(NSProgress * ))progress destination:(NSURL *(^)(NSURL *, NSURLResponse *))destination completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionHandler
{
    //远程地址
//    NSURL * URL = [NSURL URLWithString:url];
    //默认配置
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //下载句柄
    NSURLSessionDownloadTask * _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (destination) {
            destination(targetPath, response);
        }
        return destination(targetPath, response);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (completionHandler) {
            completionHandler(response, filePath, error);
        }
        
    }];
    [_downloadTask resume];//开始下载
}

@end
