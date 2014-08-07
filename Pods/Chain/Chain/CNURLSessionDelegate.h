//
//  CNURLSessionDelegate.h
//
//  Copyright (c) 2014 Chain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNURLSessionDelegate : NSObject <NSURLSessionDelegate>
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler;
@end
