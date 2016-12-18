//
//  GlobalVar.h
//  ARCleanHome
//
//  Created by Tuan Vu on 10/21/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"
#define globarVar [GlobalVar getInstance]

@interface GlobalVar : NSObject
{
    NSMutableArray <Food*> *foodList;
    NSNumber *userId;
    User *user;
 

}

@property (nonatomic ,strong) NSMutableArray *foodList;
@property (nonatomic ,strong) NSNumber *userId;
@property (nonatomic ,strong) User *user;





+(GlobalVar*)getInstance;

@end
