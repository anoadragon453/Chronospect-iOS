//
//  MessagingViewController.h
//  Chronospect
//
//  Created by Andrew Morgan on 6/20/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *messageTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UIView *messageView;
@property (strong, nonatomic) NSString* remoteUser;

- (IBAction)backPressed:(id)sender;
- (IBAction)sendPressed:(id)sender;

@end
