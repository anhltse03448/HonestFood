//
//  CommentObject.h
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface CommentObject : NSObject
@property (nonatomic , strong) NSNumber *commentId;
@property (nonatomic , strong) NSNumber *orderId;
@property (nonatomic , strong) NSNumber *foodId;
@property (nonatomic , strong) User *owner;
@property (nonatomic , strong) NSString *content;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
