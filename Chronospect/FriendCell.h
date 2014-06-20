//
//  FriendCell.h
//  Chronospect
//
//  Created by Andrew Morgan on 6/17/14.
//  Copyright (c) 2014 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *friendName;
@property (strong, nonatomic) IBOutlet UILabel *friendLocation;
@property (strong, nonatomic) IBOutlet UIImageView *friendImage;


@end
