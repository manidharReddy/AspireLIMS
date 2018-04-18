//
//  IMIHLMyProfile.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 12/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "MBProgressHUD.h"
@interface IMIHLMyProfile : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *changePassword;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backBarItem;
@property (strong, nonatomic) IBOutlet UILabel *patientmobile_lbl;
@property (strong, nonatomic) IBOutlet UILabel *patientgender_lbl;
@property (strong, nonatomic) IBOutlet UIImageView *profileicon_imgview;
@property (strong, nonatomic) IBOutlet UILabel *patientemail_lbl;
@property (strong, nonatomic) IBOutlet UILabel *patientbloodgrp_lbl;
@property (strong, nonatomic) IBOutlet UILabel *patientname_lbl;
@property (strong, nonatomic) IBOutlet UILabel *patientdob_lbl;
@property (strong, nonatomic) NSString*patientid_str;
@property (strong, nonatomic) NSString*patientname_str;
@property (strong, nonatomic) IBOutlet UILabel *mobilenumber_top_lbl;
//@property (strong, nonatomic) NSString*pageid_str;
@property (strong, nonatomic) IBOutlet UIButton *edit_btn;
@property (strong, nonatomic) IBOutlet UILabel *patientid_lbl;
@property (strong, nonatomic) IBOutlet UILabel *nationality_lbl;

- (IBAction)backBarClick:(id)sender;
- (IBAction)editProfileClick:(id)sender;
- (IBAction)changePasswordTouch:(id)sender;

@end
