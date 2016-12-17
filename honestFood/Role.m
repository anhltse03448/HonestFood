//
//  Role.m
//  honestFood
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "Role.h"

@implementation Role

-(id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        
        _roleId = dict[@"roleId"];
        _roleName = dict[@"roleName"];
        _roleType = dict[@"roleType"];
    }
    
    return self;
}

@end
