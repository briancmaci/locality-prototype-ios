//
//  SortByModel.h
//  locality
//
//  Created by Brian Maci on 6/23/15.
//  Copyright (c) 2015 briancmaci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortByModel : NSObject

typedef enum {
    
    SortProximity,
    SortTime,
    SortActivity
    
} SortByType;

@end
