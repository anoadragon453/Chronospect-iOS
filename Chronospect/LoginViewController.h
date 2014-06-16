//
//  ViewController.h
//  Chronospect
//
//  Created by Andrew Morgan on 5/18/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;

- (IBAction)loginPressed:(id)sender;

// Actions to hide keyboard
- (IBAction)backgroundTouched:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end
