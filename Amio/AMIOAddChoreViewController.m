//
//  AMIOChoreViewController.m
//  Amio
//
//  Created by Daniel Silva on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "AMIOAddChoreViewController.h"
#import "AMIOConstants.h"

@interface AMIOAddChoreViewController ()

@end


@implementation AMIOAddChoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    //Add Label for name

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, CELL_HEIGHT)];
    textView.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f];
    textView.textColor = [UIColor blackColor];
    textView.contentInset = UIEdgeInsetsMake(-60 + 5, 0, 0, 0);
    textView.backgroundColor = [UIColor colorWithRed:230.0 / 255.0 green:230.0 / 255.0 blue:230.0 / 255.0 alpha:1.0];
    [textView setScrollEnabled:NO];
    [self.view addSubview:textView];
    
    /*
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 110, 200, 25)];
    self.typeLabel.text = @"Select a Type of Task";
    self.typeLabel.textColor = [UIColor blackColor];
    [self.view addSubview:self.typeLabel];
    
    self.Typebutton1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 140, 150, 50)];
    [self.Typebutton1 setTitle:@"Periodically?" forState:UIControlStateNormal];
    self.Typebutton1.backgroundColor = [UIColor grayColor];
    [self.Typebutton1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:self.Typebutton1];
    
    self.Typebutton2 = [[UIButton alloc] initWithFrame:CGRectMake(170, 140, 140, 50)];
    [self.Typebutton2 setTitle:@"When out?" forState:UIControlStateNormal];
    self.Typebutton2.backgroundColor = [UIColor grayColor];
    [self.Typebutton2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:self.Typebutton2];
    
    self.typeAnswerLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 200, 200, 25)];
    self.typeAnswerLabel.text = @"???";
    self.typeAnswerLabel.textColor = [UIColor orangeColor];
    [self.view addSubview:self.typeAnswerLabel];
    */
    
    // UIPickView is not working, don't know why
    self.typePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(10,100,200,100)];
    [self.view addSubview:self.typePicker];
    
    
    return self;
}

//Here we initiallize the array for UIPicker,
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"amio";
    
	// Do any additional setup after loading the view.
    self.typeArray  = [[NSArray alloc]         initWithObjects:@"Periodically", @"When we run out", @" I don't know" , nil];
}

//Here we make the connection
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row  forComponent:(NSInteger)component
{
    
    return [self.typeArray objectAtIndex:row];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// returns the number of 'columns' to display for typePicker.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component for typePicker.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return 3;
}

@end
