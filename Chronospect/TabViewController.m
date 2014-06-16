//
//  TabViewController.m
//  Chronospect
//
//  Created by Andrew Morgan on 5/19/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"Getting Started"];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:vc];
        self.selectedViewController = navigation;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.hidden = YES;
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

- (IBAction)logOutPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
