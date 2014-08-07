//
//  CNURLSessionDelegate.m
//
//  Copyright (c) 2014 Chain. All rights reserved.
//

#import "CNURLSessionDelegate.h"

@interface CNURLSessionDelegate ()
@property NSArray *anchors;
@end

@implementation CNURLSessionDelegate

- (id)init {
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"chain" ofType:@"der"];
        NSData *certificateData = [NSData dataWithContentsOfFile:path];
        
        if (!certificateData) {
            NSLog(@"Error loading certificate.");
        }
        
        SecCertificateRef certificate = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)certificateData);
        
        self.anchors = @[CFBridgingRelease(certificate)];
    }
    return self;
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    SecTrustRef trust = challenge.protectionSpace.serverTrust;
    
    SecTrustSetAnchorCertificates(trust, (__bridge CFArrayRef)self.anchors);
    SecTrustSetAnchorCertificatesOnly(trust, true);
    
    SecTrustResultType result;
    OSStatus status = SecTrustEvaluate(trust, &result);
    NSURLCredential *credential = [NSURLCredential credentialForTrust:trust];

    if (status == errSecSuccess && (result == kSecTrustResultProceed || result == kSecTrustResultUnspecified)) {
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, credential);
    }
}

@end
