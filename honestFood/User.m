//
//  User.m
//  honestFood
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "User.h"

@implementation User

-(id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        
        _userId = dict[@"userId"];
        _password = dict[@"password"];
        _firstName = dict[@"firstName"];
        _lastName  = dict[@"lastName"];
        _mobile = dict[@"mobile"];
        _notiToken = dict[@"notiToken"];
        _imgUrl = dict[@"imgUrl"];
        if ([dict[@"role"] isKindOfClass:[NSNull class]] ) {
            _role = [[Role alloc]initWithDictionary:dict[@"role"]];    
        }
        
    }
    
    return self;
}

@end
