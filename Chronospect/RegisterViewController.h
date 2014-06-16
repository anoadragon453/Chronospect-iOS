//
//  RegisterViewController.h
//  Chronospect
//
//  Created by Andrew Morgan on 5/19/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface RegisterViewController : UIViewController
- (IBAction)cancelPressed:(id)sender;
- (IBAction)registerPressed:(id)sender;

// Hiding Keyboard actions
- (IBAction)backgroundTouched:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *userNameField;
@property (strong, nonatomic) IBOutlet UITextField *userEmailField;
@property (strong, nonatomic) IBOutlet UITextField *password1Field;
@property (strong, nonatomic) IBOutlet UITextField *password2Field;

@end
