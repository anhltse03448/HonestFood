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
    
 

}

@property (nonatomic ,retain) NSMutableArray *foodList;






+(GlobalVar*)getInstance;

@end
