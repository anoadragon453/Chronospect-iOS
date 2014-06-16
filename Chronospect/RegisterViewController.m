//
//  RegisterViewController.m
//  Chronospect
//
//  Created by Andrew Morgan on 5/19/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import "RegisterViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface RegisterViewController ()

@end

NSString *userPasswordHash;

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Make all text field return buttons "Done" buttons
    [self.userNameField setReturnKeyType:UIReturnKeyDone];
    [self.userEmailField setReturnKeyType:UIReturnKeyDone];
    [self.password1Field setReturnKeyType:UIReturnKeyDone];
    [self.password2Field setReturnKeyType:UIReturnKeyDone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUserToParse {
    PFUser *user = [PFUser user];
    user.username = self.userNameField.text;
    user.password = userPasswordHash;
    user.email = self.userEmailField.text;
    
    // other fields can be set just like with PFObject
    // user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            // [self showAlert:@"Successfully registered!" title:@"Hooray!"];
        } else {
            // NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

- (IBAction)cancelPressed:(id)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerPressed:(id)sender {
    // Check passwords are similar
    if (![self.password1Field.text isEqualToString:self.password2Field.text]) {
        // Warn user passwords are not matching and return
        
        // Temporary
        [self showAlert:@"The passwords do not match." title:@"Warning"];
        
        return;
    }
    
    // Check if a user's email is valid
    if (![self NSStringIsValidEmail:self.userEmailField.text]) {
        // Warn user email is invalid and return
        
        // Temporary
        [self showAlert:@"The email is invalid." title:@"Warning"];
        
        return;
    }
    
    // Convert password text into Hash.
    userPasswordHash = [self convertIntoMD5:self.password1Field.text];
    
    [self addUserToParse];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)showAlert:(NSString *)message title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

// Hiding keyboard methods
- (IBAction)backgroundTouched:(id)sender{
    [self.userNameField resignFirstResponder];
    [self.userEmailField resignFirstResponder];
    [self.password1Field  resignFirstResponder];
    [self.password2Field  resignFirstResponder];
}
- (IBAction)textFieldReturn:(id)sender{
    [sender resignFirstResponder];
}
@end
