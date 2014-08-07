//
//  Chain.h
//
//  Copyright (c) 2014 Chain Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEFAULT_BLOCK_CHAIN @"bitcoin"

@interface Chain : NSObject

@property NSString *blockChain;

+ (instancetype)sharedInstanceWithToken:(NSString *)token;
+ (instancetype)sharedInstance;

#pragma mark - Address

- (void)getAddress:(NSString *)address completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)getAddresses:(NSArray *)addresses completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;

#pragma mark - Transaction By Address

- (void)getAddressTransactions:(NSString *)address completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)getAddressesTransactions:(NSArray *)addresses completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)getAddressTransactions:(NSString *)address limit:(NSInteger)limit completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)getAddressesTransactions:(NSArray *)addresses limit:(NSInteger)limit completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;

#pragma mark - Unspent Outputs By Address

- (void)getAddressUnspents:(NSString *)address completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)getAddressesUnspents:(NSArray *)addresses completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;

#pragma mark - OP_RETURN

- (void)getAddressOpReturns:(NSString *)address completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)getTransactionOpReturn:(NSString *)hash completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)getBlockOpReturnsByHash:(NSString *)hash completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)getBlockOpReturnsByHeight:(NSInteger)height completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)getLatestBlockOpReturnsWithCompletionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;

#pragma mark - Transaction

- (void)getTransaction:(NSString *)hash completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)sendTransaction:(NSString *)hex completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;

#pragma mark - Block

- (void)getBlockByHash:(NSString *)hash completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)getBlockByHeight:(NSInteger)height completionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;
- (void)getLatestBlockWithCompletionHandler:(void (^)(NSDictionary *dictionary, NSError *error))completionHandler;

@end
