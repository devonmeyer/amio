//
//  AMIOGroup.h
//  Amio
//
//  Created by Devon on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface AMIOGroup : PFObject <PFSubclassing>
{
    
    
}


+ (NSString *) parseClassName;

// Better

+(void) getGroupByID:(NSString *)anId withTarget:(id)aTarget withSelector:(SEL)aSelector;

// Not as good

+(void) getGroupByID:(NSString *)anId withBlock:(void (^)(NSArray *objects, NSError *error)) block;

@property (retain) NSString * name;
@property (retain) NSString * joinCode;
@property NSMutableArray * members;

@end
