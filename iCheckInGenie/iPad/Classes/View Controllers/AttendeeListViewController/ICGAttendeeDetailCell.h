//
//  ICGAttendeeDetailCell.h
//  iCheckInGenie
//
//  Created by Krishna on 05/03/14.
//  Copyright (c) 2014 Gniyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICGAttendeeDetailCell : UITableViewCell
{
    NSMutableArray *columns;
}
@property (nonatomic, strong) IBOutlet UILabel *snoLabel;
@property (nonatomic, strong) IBOutlet UILabel *infoLabel;
@property (nonatomic, strong) IBOutlet UILabel *additionalInfoLabel;
@property (nonatomic, strong) IBOutlet UILabel *checkInLabel;

@property (nonatomic, strong) IBOutlet UIButton *checkedInButton;
@end
