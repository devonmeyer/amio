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


+ (NSString *) parseClassName;

// Custom Queries

+ (NSArray *) getTasksForUser:(AMIOUser *)aUser;

+ (NSArray *) getTasksForGroup:(AMIOGroup *)aGroup;

+ (PFQuery *) getQueryTasksForUser:(AMIOUser *)aUser;

+ (PFQuery *) getQueryTasksForGroup:(AMIOGroup *)aGroup;


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
