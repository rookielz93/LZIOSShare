//
//  LZMediaShare.h
//  VideoDownloader
//
//  Created by lz on 2023/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : int {
    LZMediaSharePlatformIns,
} LZMediaSharePlatform;

typedef void (^LZMediaShareCompletion) (BOOL success, NSError  * _Nullable error);

@interface LZMediaShare : NSObject

+ (NSString *)platformURL:(LZMediaSharePlatform)platform;

+ (BOOL)hasPlatform:(LZMediaSharePlatform)platform;

+ (void)share:(NSString *)path caption:(NSString *)caption to:(LZMediaSharePlatform)platform completion:(LZMediaShareCompletion)completion;

+ (void)open:(LZMediaSharePlatform)platform completion:(LZMediaShareCompletion)completion;

@end

NS_ASSUME_NONNULL_END
