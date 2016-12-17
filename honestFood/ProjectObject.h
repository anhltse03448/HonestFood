//
//  ProjectObject.h
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectObject : Nutrition
@property (nonatomic , strong) NSNumber *date;
-(id)initWithDictionary:(NSDictionary*)dict;
@end
