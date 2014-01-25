//
//  AMIOTask.h
//  Amio
//
//  Created by Devon on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import <Parse/Parse.h>
@class AMIOUser, AMIOGroup;

enum AMIOTaskType {
    
    AMIOTaskTypeNone,
    AMIOTaskTypeRecurring,
    AMIOTaskTypeAnytime,
    AMIOTaskTypeOnce
    
};

enum AMIOTaskFrequencyUnit {
    
    AMIOTaskFrequencyNone,
    AMIOTaskFrequencyDay,
    AMIOTaskFrequencyWeek,
    AMIOTaskFrequencyMonth
    
};

enum AMIOTaskStatus {
    
    AMIOTaskStatusUnassigned,
    AMIOTaskStatusUpcoming,
    AMIOTaskStatusDue
    
};

@interface AMIOTask : PFObject <PFSubclassing>
{
    
}


+ (NSString *) parseClassName;

// Custom Queries

/*
 
 Common, supported, best.
 
 */

+ (void) getTasksForUser:(AMIOUser *)aUser withTarget:(id)aTarget withSelector:(SEL)aSelector;

+ (void) getTasksForGroup:(AMIOGroup *)aGroup withTarget:(id)aTarget withSelector:(SEL)aSelector;

+ (void) getTasksForGroup:(AMIOGroup *)aGroup exceptUser:(AMIOUser *)aUser  withTarget:(id)aTarget withSelector:(SEL)aSelector;

/*
 
 Uncommon but useful on occassion. Do not use in production.
 
 */


+ (NSArray *) getTasksForUser:(AMIOUser *)aUser;

+ (NSArray *) getTasksForGroup:(AMIOGroup *)aGroup;

+ (PFQuery *) getQueryTasksForUser:(AMIOUser *)aUser;

+ (PFQuery *) getQueryTasksForGroup:(AMIOGroup *)aGroup;

+ (void) getTasksForUser:(AMIOUser *)aUser withBlock:(void (^)(NSArray *objects, NSError *error)) block;

+ (void) getTasksForGroup:(AMIOGroup *)aGroup withBlock:(void (^)(NSArray *objects, NSError *error)) block;

+ (void) getTasksForGroup:(AMIOGroup *)aGroup exceptUser:(AMIOUser *)aUser withBlock:(void (^)(NSArray *, NSError *))block;



// Instance Methods

- (void) taskCompleted;

- (void) assignUserToTaskWithArray:(NSArray *) objects withError:(NSError *) error;


// Member Properties

@property (retain) NSString * name;
@property AMIOUser * assignee;
@property AMIOGroup * group;

@property enum AMIOTaskType type;

@property NSDate * dueDate;
@property int frequency;
@property enum AMIOTaskFrequencyUnit frequencyUnit;

@property enum AMIOTaskStatus status;








@end
