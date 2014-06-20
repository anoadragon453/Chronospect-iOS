//
//  FindFriendsTableViewController.m
//  Chronospect
//
//  Created by Andrew Morgan on 6/17/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import "FindFriendsTableViewController.h"
#import <Parse/Parse.h>
#import "FriendCell.h"
#import "ProfileViewController.h"
#import "SWRevealViewController.h"

@interface FindFriendsTableViewController ()

@end

NSMutableArray *friendsArray;
NSString *usernameOfProfileToView;
ProfileViewController *profileVC;

@implementation FindFriendsTableViewController

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
    
    // Remove back button
    [self.navigationItem setHidesBackButton:YES];
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Add in the refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"Friends";
    
    friendsArray = [[NSMutableArray alloc] init];
    
    [self getListOfFriends];
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
    return [friendsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PFObject *friend = [friendsArray objectAtIndex:indexPath.row];
    cell.friendName.text = friend[@"username"];
    
    if (!friend[@"location"]) {
        cell.friendLocation.text = @"Location Hidden";
    }else{
        cell.friendLocation.text = friend[@"location"];
    }
    
    // Set avatar image if available
    if (!friend[@"avatar"]) {
        cell.friendImage.image = [UIImage imageNamed:@"blank-avatar.jpg"];
    }else{
        cell.friendImage.image = friend[@"avatar"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
     PFObject* friend = [friendsArray objectAtIndex:indexPath.row];
     usernameOfProfileToView = friend[@"username"];
     
     profileVC = [[ProfileViewController alloc] init];
     
     [profileVC setUsername:usernameOfProfileToView];
     
     //[self.navigationController pushViewController:profileVC animated:YES];
     [self presentModalViewController:profileVC animated:YES];
 }

-(void)getListOfFriends {
    NSLog(@"Finding Friends...");
    PFQuery *userQuery = [PFUser query];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Find succeeded.");
            // Do something with the found objects
            for (PFObject *object in objects) {
                [friendsArray addObject:object];
                NSLog(@"%@", object.objectId);
                
                // Reload tableview
                [self.tableView reloadData];
                
                // End refreshing if user pulled-down to refresh
                [self.refreshControl endRefreshing];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void) refreshInvoked:(id)sender forState:(UIControlState)state {
    [friendsArray removeAllObjects];
    [self getListOfFriends];
}

@end
