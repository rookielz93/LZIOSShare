//
//  LZMediaShare.m
//  VideoDownloader
//
//  Created by lz on 2023/10/28.
//

#import "LZMediaShare.h"
#import "LZLog.h"

@implementation LZMediaShare

+ (NSString *)platformURL:(LZMediaSharePlatform)platform {
    switch (platform) {
        case LZMediaSharePlatformIns:
            return @"instagram://app";
        default:
            return @"";
    }
}

+ (BOOL)hasPlatform:(LZMediaSharePlatform)platform {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[self platformURL:platform]]];
}

+ (void)share:(NSString *)path caption:(NSString *)caption to:(LZMediaSharePlatform)platform completion:(LZMediaShareCompletion)completion {
    if (![self hasPlatform:platform]) {
        completion(NO, nil);
        return;
    }
    
    switch (platform) {
        case LZMediaSharePlatformIns:
            [self shareToIns:path caption:caption completion:completion];
            break;
            
        default:
            break;
    }
}

+ (void)open:(LZMediaSharePlatform)platform completion:(LZMediaShareCompletion)completion {
    if (![self hasPlatform:platform]) {
        if (completion) completion(NO, nil);
        return;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self platformURL:platform]] options:@{} completionHandler:^(BOOL success) {
        if (completion) completion(success, nil);
    }];
}

// MARK: - Private

+ (void)shareToIns:(NSString *)path caption:(NSString *)caption completion:(LZMediaShareCompletion)completion {
    NSString *url = [NSString stringWithFormat:@"instagram://library?AssetPath=%@&InstagramCaption=%@",
                     path,
                     [caption stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:^(BOOL success) {
        LZLoggerInfo(@"xxxx: %d", success);
        if (completion) completion(success, nil);
    }];
}

@end
