//
//  MainNavigatorViewController.h
//  Chronospect
//
//  Created by Andrew Morgan on 5/18/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PPRevealSideViewController/PPRevealSideViewController.h>

@interface MainNavigatorViewController : UIViewController

@property (strong, nonatomic) UIWindow *window;

+(PPRevealSideViewController*) revealSideViewController;



@end
