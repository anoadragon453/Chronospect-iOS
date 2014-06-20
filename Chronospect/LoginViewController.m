//
//  ViewController.m
//  Chronospect
//
//  Created by Andrew Morgan on 5/18/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import "LoginViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize backgroundImage;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    backgroundImage.image = [UIImage imageNamed:@"login-background.png"];
    
    /* ios 7 Change */
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:.4 green:.44 blue:.49 alpha:.5]];
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0];
        shadow.shadowOffset = CGSizeMake(0, 1);
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                               shadow, NSShadowAttributeName,
                                                               [UIFont fontWithName:@"Helvetica Neue" size:21.0], NSFontAttributeName, nil]];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(id)sender {
    [PFUser logInWithUsernameInBackground:self.usernameField.text   password:[self convertIntoMD5:self.passwordField.text]
                block:^(PFUser *user, NSError *error) {
                    if (user) {
                        // Log the user in
                        [self logUserIn];
                        self.usernameField.text = @"";
                        self.passwordField.text = @"";
                        
                    } else {
                        // The login failed. Check error to see why.
                        [self showAlert:[error userInfo][@"error"] title:@"Error"];
                    }
                }];
}

- (void)logUserIn{
    [self performSegueWithIdentifier:@"login" sender:self];
}

- (void)showAlert:(NSString *)message title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

// Methods for hiding keyboard
- (IBAction)backgroundTouched:(id)sender{
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (IBAction)textFieldReturn:(id)sender{
    [sender resignFirstResponder];
}

- (NSString *)convertIntoMD5:(NSString *) string{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr, (u_int32_t)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [resultString appendFormat:@"%02x", digest[i]];
    return  resultString;
}

@end
