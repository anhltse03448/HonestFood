//
//  Role.h
//  honestFood
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Role : NSObject

-(id)initWithDictionary:(NSDictionary*)dict;

@property (nonatomic , strong) NSNumber *roleId;
@property (nonatomic , copy) NSString *roleName;
@property (nonatomic , copy) NSNumber *roleType;


@end
