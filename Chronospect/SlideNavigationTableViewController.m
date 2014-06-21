//
//  SlideNavigationTableViewController.m
//  Chronospect
//
//  Created by Andrew Morgan on 5/19/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import "SlideNavigationTableViewController.h"
#import "SlideNavigationTableViewCell.h"
#import "RegisterViewController.h"
#import "SWRevealViewController.h"

// Classes to segue to
#import "WallViewController.h"

@interface SlideNavigationTableViewController ()

@end

NSArray *cellTitles;
NSArray *cellImages;
NSArray *cellIdentifiers;

@implementation SlideNavigationTableViewController

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
    
    // Set the background and seperator colors
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.15f alpha:0.2f];
    
    cellIdentifiers = [[NSArray alloc] initWithObjects:@"title", @"wall", @"invites", @"friends", @"empty", @"my profile", @"account settings", @"log out", nil];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [cellIdentifiers objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Remove the selection color
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Add Support for multiple sections
    int row = (int)indexPath.row;
    if (indexPath.section == 1) {
        row+=4;
    }
    
    // Check for user logout
    if ([[cellTitles objectAtIndex:row] isEqualToString:@"Log out"]) {
        
        // Log the user out.
        [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
        
        //[[MainNavigatorViewController revealSideViewController] popViewControllerAnimated:YES];
        //[self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* c = [sb instantiateViewControllerWithIdentifier:[cellTitles objectAtIndex:row]];
    
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:c];
    [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Set the title of navigation bar
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[cellIdentifiers objectAtIndex:indexPath.row] capitalizedString];
    
    if ([segue.identifier isEqualToString:@"log out"]) {
        // Log the user out
    }
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
}

@end
