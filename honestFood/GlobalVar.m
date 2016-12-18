//
//  GlobalVar.m
//  ARCleanHome
//
//  Created by Tuan Vu on 10/21/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "GlobalVar.h"


@implementation GlobalVar

@synthesize foodList,userId,user;

static GlobalVar *instance = nil;

+(GlobalVar*)getInstance;
{
    @synchronized (self) {
        
        if (instance == nil) {
            
            instance = [[GlobalVar alloc]init];
            
            
            
        }
    }
    
    return instance;
    
}

-(id)init
{
    self = [super init];
    if (self) {
        foodList = [NSMutableArray new];
        user = [User new];
    }
    
    return self;
}



@end
