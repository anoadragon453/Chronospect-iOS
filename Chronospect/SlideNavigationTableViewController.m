//
//  SlideNavigationTableViewController.m
//  Chronospect
//
//  Created by Andrew Morgan on 5/19/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import "SlideNavigationTableViewController.h"
#import "SlideNavigationTableViewCell.h"
#import "MainNavigatorViewController.h"
#import <PPRevealSideViewController/PPRevealSideViewController.h>
#import "RegisterViewController.h"

@interface SlideNavigationTableViewController ()

@end

NSArray *cellTitles;
NSArray *cellImages;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    cellTitles = [[NSArray alloc] initWithObjects:@"Find Friends", @"Invites", @"Wall", @"Getting Started", @"My Profile", @"Account", @"Log out", nil];
    cellImages = [[NSArray alloc] initWithObjects:@"friends.png", @"invites.png", @"wall.png", @"info.png", @"user-light.png", @"account.png", @"logout.png", nil];
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
    if (section==0) {
        return 4;
    }else{
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SlideNavigationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.cellLabel.text = [cellTitles objectAtIndex:indexPath.row];
        cell.cellImage.image = [UIImage imageNamed:[cellImages objectAtIndex:indexPath.row]];
    }else{
        cell.cellLabel.text = [cellTitles objectAtIndex:indexPath.row + 4];
        cell.cellImage.image = [UIImage imageNamed:[cellImages objectAtIndex:indexPath.row + 4]];
    }
    
    return cell;
}

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
        
        [[MainNavigatorViewController revealSideViewController] popViewControllerAnimated:YES];
        //[self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* c = [sb instantiateViewControllerWithIdentifier:[cellTitles objectAtIndex:row]];
    
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:c];
    [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
