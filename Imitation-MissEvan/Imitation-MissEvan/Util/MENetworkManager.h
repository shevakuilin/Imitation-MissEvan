//
//  MENetworkManager.h
//  Imitation-MissEvan
//
//  Created by shevchenko on 17/1/2.
//  Copyright © 2017年 xkl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MENetworkManager : NSObject

/** 下载音频
 * @param url 下载地址
 * @param progress 下载进度
 * @param destination 要求返回一个URL, 返回的这个URL就是文件的位置的路径
 * @param completionHandler 下载完成操作,filePath就是下载文件的位置
*/
+ (void)downFromServerWithSoundUrl:(NSURL *)url progress:(void (^)(NSProgress * downloadProgress))progress destination:(NSURL * (^)(NSURL * targetPath, NSURLResponse * response))destination completionHandler:(void (^)(NSURLResponse * response, NSURL * filePath, NSError * error))completionHandler;



@end
