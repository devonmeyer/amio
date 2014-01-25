//
//  AMIOGroup.m
//  Amio
//
//  Created by Devon on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "AMIOGroup.h"
#import <Parse/PFObject+Subclass.h>


@implementation AMIOGroup

@dynamic name, joinCode;

+ (NSString *)parseClassName {
    return @"AMIOGroup";
}


+(void) getGroupByID:(NSString *)anId withBlock:(void (^)(NSArray *objects, NSError *error)) block
{
    
    PFQuery *query = [PFQuery queryWithClassName:[self parseClassName]];
    [query whereKey:@"objectId" equalTo:anId];
    
    [query findObjectsInBackgroundWithBlock:block];
    
}

@end
