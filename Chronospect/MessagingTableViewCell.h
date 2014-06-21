//
//  MessagingTableViewCell.h
//  Chronospect
//
//  Created by Andrew Morgan on 6/20/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagingTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userAvatar;
@property (strong, nonatomic) IBOutlet UILabel *messageText;

@end
