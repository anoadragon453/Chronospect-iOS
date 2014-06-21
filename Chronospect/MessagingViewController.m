//
//  MessagingViewController.m
//  Chronospect
//
//  Created by Andrew Morgan on 6/20/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import "MessagingViewController.h"
#import "MessagingTableViewCell.h"
#import <Parse/Parse.h>

NSMutableArray* messageArray;
UIControl* activeField;
NSTimer *timer;

@implementation MessagingViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _messageTextField.delegate = self;
    [_messageTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self registerForKeyboardNotifications];
    
    // Have the send button disabled by default
    _sendButton.enabled = NO;
    
    messageArray = [[NSMutableArray alloc] init];
    
    [self getMessagesFromServerWithLocalUser:[[PFUser currentUser] username] remoteUser:_remoteUser];
    
    // Set up a timer for checking messages
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self  selector:@selector(checkForNewMessages:) userInfo:nil repeats:YES];
    
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
    return [messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessagingTableViewCell *cell;
    
    PFObject *message = [messageArray objectAtIndex:indexPath.row];
    
    // Determine whether the message originated from the current user, or a remote user.
    if ([message[@"localUser"] isEqualToString:[[PFUser currentUser] username]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"localUserMessage" forIndexPath:indexPath];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"remoteUserMessage" forIndexPath:indexPath];
    }
    
    // Set avatar image if available
    cell.userAvatar.image = [UIImage imageNamed:@"blank-avatar.jpg"];
    
    // Set message text
    cell.messageText.text = message[@"messageText"];
    
    return cell;
}

- (IBAction)backPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendPressed:(id)sender {
    _sendButton.enabled = NO;
    [_messageTextField resignFirstResponder];
    
    [self sendMessageToServerWithMessage:_messageTextField.text fromUser:[[PFUser currentUser] username] toUser:_remoteUser];
    [self getMessagesFromServerWithLocalUser:[[PFUser currentUser] username] remoteUser:_remoteUser];
}

- (void)checkForMessageText {
    if ([_messageTextField.text isEqualToString:@""]) {
        _sendButton.enabled = NO;
    }else{
        _sendButton.enabled = YES;
    }
}

// If only I could pass parameters with @selector...
- (void)checkForNewMessages:(NSTimer*)t {
    [self getMessagesFromServerWithLocalUser:[[PFUser currentUser] username] remoteUser:_remoteUser];
}

- (void)getMessagesFromServerWithLocalUser:(NSString *)localUser remoteUser:(NSString*)remoteUser {
    [messageArray removeAllObjects];
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    NSArray *users = @[localUser,remoteUser];
    [query whereKey:@"localUser" containedIn:users];
    [query whereKey:@"remoteUser" containedIn:users];
    [query orderByAscending:@"createdAt"];
    query.limit = 20; // limit to at most 20 results
    NSLog(@"localUser is %@, remoteUser is %@", localUser, remoteUser);
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // Do something with the found objects
            for (PFObject *object in objects) {
                [messageArray addObject:object];
                NSLog(@"Found message with remoteUser %@", remoteUser);
                
                // Reload tableview
                [self.tableView reloadData];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)sendMessageToServerWithMessage:(NSString*)message fromUser:(NSString*)localUser toUser:(NSString*)remoteUser {
    // Upload new message to Parse
    PFObject *newMessage = [PFObject objectWithClassName:@"Messages"];
    newMessage[@"messageText"] = message;
    newMessage[@"localUser"] = localUser;
    newMessage[@"remoteUser"] = remoteUser;
    [newMessage saveInBackground];
    
    // Clear message field
    _messageTextField.text = @"";
    
    // Update the local messages array with the new message
    [messageArray addObject:newMessage];
}

#pragma mark - Keyboard Content Handling

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [activeField resignFirstResponder];
    [timer invalidate];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    activeField = _messageTextField;
    [self setViewMovedUp:YES withNotification:aNotification];
}

-(void)textFieldDidChange {
    [self checkForMessageText];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self setViewMovedUp:NO withNotification:aNotification];
    activeField = nil;
}

- (void)setViewMovedUp:(BOOL)movedUp withNotification:(NSNotification*)aNotification{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1];
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect viewFrame = _messageView.frame;
    
    if (movedUp) {
        viewFrame.origin.y = kbSize.height + 90;
    } else {
        //viewFrame.origin.y = 0;
    }
    _messageView.frame = viewFrame;
    
    [UIView commitAnimations];
}

@end
