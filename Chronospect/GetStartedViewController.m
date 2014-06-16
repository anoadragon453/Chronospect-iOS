//
//  GetStartedViewController.m
//  Chronospect
//
//  Created by Andrew Morgan on 5/18/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import "GetStartedViewController.h"

@interface GetStartedViewController ()

@end

@implementation GetStartedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Remove Back button
    [self.navigationItem setHidesBackButton:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)popOutPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITableViewController* controller;
    
    controller = [storyboard instantiateViewControllerWithIdentifier:@"SlideOutController"];
    [self.revealSideViewController pushViewController:controller onDirection:PPRevealSideDirectionLeft animated:YES];
}
@end
