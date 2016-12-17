//
//  AppDelegate.m
//  honestFood
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "AppService.h"

@interface AppService ()

@property (nonatomic, strong) AFHTTPSessionManager* manager;

@end

@implementation AppService



+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static AppService* shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[AppService alloc] init];
    });
    
    return shareInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        [self configureManager];
    }
    
    return self;
}

- (void)configureManager
{
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseUrl]];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    _manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
}

-(void)postWithUrl:(NSString*)url param:(NSDictionary*)param success:(success)success failure:(failure)failure
{
    NSURLSessionDataTask* dataTask = [_manager POST:url parameters:param progress:^(NSProgress* _Nonnull uploadProgress) {
        
    }
                                            success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
                                                
                                                if (success) {
                                                    success(task, responseObject);
                                                }
                                            }
                                            failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
                                                NSLog(@"error: %@", error);
                                                
                                                if (failure) {
                                                    failure(task, error);
                                                }
                                                
                                            }];
    
    [dataTask resume];
}

-(void)getWithUrl:(NSString*)url param:(NSDictionary*)param success:(success)success failure:(failure)failure
{
  

    NSURLSessionDataTask* dataTask = [_manager GET:url parameters:param progress:^(NSProgress* _Nonnull downloadProgress) {
        
    }
                                           success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
                                               
                                               if (success) {
                                                   success(task, responseObject);
                                               }
                                               
                                           }
                                           failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
                                               
                                               if (failure) {
                                                   failure(task, error);
                                               }
                                           }];
    
    [dataTask resume];
}



@end
