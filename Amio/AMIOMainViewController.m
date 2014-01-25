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
#import <Parse/Parse.h>

@interface AMIOMainViewController ()

@end

@implementation AMIOMainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"amio";
    
    [self testParse];
}


// Test method for Parse.
- (void) testParse
{
    
    AMIOTask * testTask = [AMIOTask object];
    
    AMIOUser * testUser = [AMIOUser object];
    
    [testUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [testTask setName:@"Some other Task"];
        [testTask setType:AMIOTaskTypeOnce];
        [testTask setDueDate:[NSDate date]];
        [testTask setAssignee:testUser];
        
        [testTask saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            [AMIOTask getTasksForUser:testUser withBlock:^(NSArray *objects, NSError *error) {
                
                NSLog([NSString stringWithFormat:@"%@", objects]);
                
            }];
            
            
        }];
        
        //NSLog([NSString stringWithFormat:@"%@", test]);

        
    }];
    
    
    
    
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.text = @"test";
    }

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, CELL_HEIGHT)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CELL_PADDING, 8, tableView.frame.size.width, CELL_HEIGHT - 16)];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:24.0f]];
    label.textColor = [UIColor whiteColor];
    
    UILabel *settings = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - CELL_HEIGHT, 0, CELL_HEIGHT, CELL_HEIGHT)];

    if (section == 0) {
        [label setText:@"DEVON"];
        settings.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconSettingsSelf"]];
    } else {
        [label setText:@"SPTREES"];
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

@end
