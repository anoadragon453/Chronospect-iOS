//
//  InvitesViewController.m
//  Chronospect
//
//  Created by Andrew Morgan on 6/20/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import "InvitesViewController.h"
#import "SWRevealViewController.h"

@implementation InvitesViewController

-(void)viewDidLoad{
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

@end
