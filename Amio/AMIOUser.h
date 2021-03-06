//
//  AMIOUser.h
//  Amio
//
//  Created by Devon on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface AMIOUser : PFObject <PFSubclassing>

+(NSString *) parseClassName;

// Better

+(void) getUserByID:(NSString *)anId withTarget:(id)aTarget withSelector:(SEL)aSelector;

// Not as good

+(void) getUserByID:(NSString *)anId withBlock:(void (^)(NSArray *objects, NSError *error)) block;

+(NSArray *) getUserByID:(NSString *)anId;

@property NSString * name;

@end
