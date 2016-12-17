//
//  CommentObject.m
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "CommentObject.h"

@implementation CommentObject
-(id)initWithDictionary:(NSDictionary*)dict;
{
    self = [super init];
    if (self) {
        
        self.commentId = dict[@"commentId"];
        self.orderId = dict[@"orderId"];
        self.foodId = dict[@"foodId"];
        self.owner = [[User alloc]initWithDictionary:dict[@"owner"]];
        self.content = dict[@"content"];
    }    
    return self;
    
}

@end
