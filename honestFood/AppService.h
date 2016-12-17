//
//  AppDelegate.m
//  honestFood
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


#define API [AppService shareInstance]

typedef void (^success)(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject);
typedef void (^failure)(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error);

@interface AppService : NSObject




NS_ASSUME_NONNULL_BEGIN

+ (instancetype)shareInstance;

-(void)postWithUrl:(NSString*)url param:(NSDictionary*)param success:(success)success failure:(failure)failure;
-(void)getWithUrl:(NSString*)url param:(NSDictionary*)param success:(success)success failure:(failure)failure;

NS_ASSUME_NONNULL_END







@end
