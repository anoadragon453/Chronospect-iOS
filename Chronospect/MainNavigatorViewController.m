//
//  MainNavigatorViewController.m
//  Chronospect
//
//  Created by Andrew Morgan on 5/18/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import "MainNavigatorViewController.h"

@interface MainNavigatorViewController ()

@end

PPRevealSideViewController* revealSideViewController;

@implementation MainNavigatorViewController

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
    // Do any additional setup after loading the view.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* controller;
    
    controller = [storyboard instantiateViewControllerWithIdentifier:@"Getting Started"];
    
    revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:controller];
    
    [self.view addSubview:revealSideViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(PPRevealSideViewController*) revealSideViewController
{
    return revealSideViewController;
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

@end
