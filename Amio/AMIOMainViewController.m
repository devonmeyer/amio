//
//  AMIOMainViewController.m
//  Amio
//
//  Created by Jesse Chand on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "AMIOConstants.h"
#import "AMIOMainViewController.h"
#import "AMIOTask.h"
#import "AMIOGroup.h"
#import "AMIOUser.h"
#import "AMIOAddChoreViewController.h"
#import "MCSwipeTableViewCell.h"
#import <Parse/Parse.h>

@interface AMIOMainViewController () <MCSwipeTableViewCellDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *content;
@property (nonatomic, strong) NSMutableArray *allChores;
@property (nonatomic, strong) MCSwipeTableViewCell *cellToDelete;


@end

@implementation AMIOMainViewController

@synthesize activeGroup, activeUser;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    [self initBlocks];
    
    if (self) {
        
        // First init with empty arrays
        _content = [[NSMutableArray alloc] init];
        _allChores = [[NSMutableArray alloc] init];
        
        // Now ask server to retrieve dynamic data
        [self retrieveGroupAndUser];
        //;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"amio";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addChore)];
    [[UIBarButtonItem appearance] setTintColor:[UIColor orangeColor]];
}

// Test method for Parse.

- (void) initBlocks
{
    
    loadContentArray = ^(NSArray * objects, NSError * error) {
    
        if (!error) {
        NSLog(@"loadContentArray : Loading content with %d objects", [objects count]);
            _content = [NSMutableArray arrayWithArray:objects];
            
            
            [self.tableView reloadData ];
            
        } else {
            NSLog(@"%@", [error debugDescription]);
        }
        
    };
    
    loadAllChoresArray = ^(NSArray * objects, NSError * error) {
        
        if (!error) {
            NSLog(@"loadAllChoresArray : Loading content with %d objects", [objects count]);
            _allChores = [NSMutableArray arrayWithArray:objects];
            
            [self.tableView reloadData ];
            
        } else {
            NSLog(@"%@", [error debugDescription]);
        }
    };
    
    loadUser = ^(NSArray * objects, NSError * error) {
        
        if (!error) {
            
            NSLog(@"loadUser : Loading content with %d objects", [objects count]);
            
            [self setActiveUser:objects[0]];
            
            [AMIOTask getTasksForUser:[self activeUser] withBlock:loadContentArray];
            
            [AMIOGroup getGroupByID:TEST_GROUP withBlock:loadGroup];
            
            [self.tableView reloadData ];
            
        } else {
            
            NSLog(@"%@", [error debugDescription]);
            
        }
    };
    
    loadGroup = ^(NSArray * objects, NSError * error) {
        
        if (!error) {
            
            NSLog(@"loadGroup : Loading content with %d objects", [objects count]);
            
            [self setActiveGroup:objects[0]];
            
            NSLog(@"%@", activeGroup);
            
            //[self createSomeTasks];
            
            
            [AMIOTask getTasksForGroup:[self activeGroup] exceptUser:[self activeUser] withBlock:loadAllChoresArray];
            
            [self.tableView reloadData];
            
        } else {
            
            NSLog(@"%@", [error debugDescription]);
            
        }
    };

    
}


- (void) createSomeTasks
{
    
    NSArray * actions = [NSArray arrayWithObjects:@"Do", @"Wash", @"Clean", @"Make", nil];
    
    NSArray * objects = [NSArray arrayWithObjects:@"the dishes.", @"roscoe's shit.", @"dinner.", @"the bathroom", @"the living room", @"kevin's nasty laundry.", nil];
    
    AMIOUser * userOne = [AMIOUser getUserByID:TEST_USER_ONE][0];
    AMIOUser * userTwo = [AMIOUser getUserByID:TEST_USER_TWO][0];
    
    for (int i = 0; i < 4; i ++) {
        
        AMIOTask * task = [AMIOTask object];
        NSString * name = [NSString stringWithFormat:@"%@ %@", [actions objectAtIndex:(arc4random() % [actions count])], [objects objectAtIndex:(arc4random() % [objects count])]];
        
        [task setName:name];
        if (i % 2) {
            [task setAssignee:userOne];
        } else {
            [task setAssignee:userTwo];
        }
        
        [task setGroup:[self activeGroup]];
        
        [task setDueDate:[NSDate dateWithTimeIntervalSinceNow:(arc4random() % 604800)]];
        
        [task setFrequency:1];
        [task setFrequencyUnit:AMIOTaskFrequencyWeek];
        [task setStatus:AMIOTaskStatusUpcoming];
        
        [task saveInBackground];
        
        
        
        
    }
    
}

- (void) retrieveGroupAndUser
{
    
    // Get the active user.. Currently in test mode.
    
    if (TESTING) {
                
        if (IS_USER_ONE) {
            [AMIOUser getUserByID:TEST_USER_ONE withBlock:loadUser];
        } else {
            [AMIOUser getUserByID:TEST_USER_TWO withBlock:loadUser];
        }
        
        
    } else {
        
        // ... TODO ...
        
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [_content count];
    } else {
        return [_allChores count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if (indexPath.section == 0) {
        MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil) {
            cell = [[MCSwipeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // iOS 7 separator
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self configureCell:cell forRowAtIndexPath:indexPath];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // iOS 7 separator
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *profileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CELL_HEIGHT, CELL_HEIGHT)];
        profileView.backgroundColor = [UIColor greenColor];
        [cell addSubview:profileView];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CELL_PADDING + CELL_HEIGHT, 0, self.tableView.frame.size.width - 60 - CELL_PADDING*2 - CELL_HEIGHT, CELL_HEIGHT)];
        [textLabel setText:[[_allChores objectAtIndex:indexPath.row] name]];
        [textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f]];
        [cell addSubview:textLabel];
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 60 - CELL_PADDING, 0, 60, CELL_HEIGHT)];
        [dateLabel setText:@"Jan 23"];
        [dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f]];
        dateLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:dateLabel];
        
        return cell;
    }
}

- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIView *checkView = [self viewWithImageName:@"check"];
    UIColor *greenColor = [UIColor colorWithRed:85.0 / 255.0 green:213.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];

    // Setting the default inactive state color to the tableView background color
    //[cell setDefaultColor:[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0]];
    
    [cell setDelegate:self];
    [cell.textLabel setText:[[_content objectAtIndex:indexPath.row] name]];
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f]];

    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 60 - CELL_PADDING, 0, 60, CELL_HEIGHT)];
    [dateLabel setText:@"Jan 23"];
    [dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f]];
    dateLabel.textAlignment = NSTextAlignmentRight;
    [cell addSubview:dateLabel];
    
    [cell setSwipeGestureWithView:checkView color:greenColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"Cross\" cell");
        
        _cellToDelete = cell;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Task Complete"
                                                            message:@"Are you sure you completed this task?"
                                                           delegate:self
                                                  cancelButtonTitle:@"No"
                                                  otherButtonTitles:@"Yes", nil];
        [alertView show];
    }];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, CELL_HEIGHT)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CELL_PADDING, 8, tableView.frame.size.width, CELL_HEIGHT - 16)];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:24.0f]];
    label.textColor = [UIColor whiteColor];
    
    UILabel *settings = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - CELL_HEIGHT + 4, 4, CELL_HEIGHT-8, CELL_HEIGHT-8)];

    if (section == 0) {
        [label setText:@"Devon"];
        settings.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconSettingsSelf"]];
    } else {
        [label setText:@"Our Apartment"];
        settings.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconSettingsGroup"]];
    }
    
    [view addSubview:label];
    [view addSubview:settings];
    [view setBackgroundColor:[UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0]];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}

- (void)addChore {
    NSLog(@"Pressed: Add chore");
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @""
                                   style: UIBarButtonItemStyleDone
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    
    AMIOAddChoreViewController *choreViewController = [[AMIOAddChoreViewController alloc] init];
    [self.navigationController pushViewController:choreViewController animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // No
    if (buttonIndex == 0) {
        [_cellToDelete swipeToOriginWithCompletion:^{
            NSLog(@"Swiped back");
        }];
        _cellToDelete = nil;
    }
    
    // Yes
    else {
        
        int myIndex = [[self.tableView indexPathForCell:_cellToDelete] row];
        
        AMIOTask * theTask = [_content objectAtIndex:myIndex];

        [theTask taskCompleted];
        
        NSArray * toDelete = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:myIndex inSection:0], nil];
        
        NSLog(@"%@", toDelete);
        
        [self.tableView deleteRowsAtIndexPaths:toDelete
                              withRowAnimation:UITableViewRowAnimationFade];
  
        [_content removeObject:theTask];

        
    }
}

@end
