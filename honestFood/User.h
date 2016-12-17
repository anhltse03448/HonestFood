//
//  User.h
//  honestFood
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Role.h"

@interface User : NSObject

@property (nonatomic , strong) NSNumber *userId;
@property (nonatomic , copy) NSString *username;
@property (nonatomic , copy) NSString *password;
@property (nonatomic , copy) NSString *firstName;
@property (nonatomic , copy) NSString *lastName;
@property (nonatomic , copy) NSString *mobile;
@property (nonatomic , copy) NSString *notiToken;
@property (nonatomic , copy) NSString *imgUrl;
@property (nonatomic , strong) Role *role;

-(id)initWithDictionary:(NSDictionary*)dict;



@end
