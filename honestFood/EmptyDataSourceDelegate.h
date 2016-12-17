//
//  EmptyDataSourceDelegate.h
//  honestFood
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmptyDataSourceDelegate : NSObject<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

+ (instancetype)sharedInstance;

@end
