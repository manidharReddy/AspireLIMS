//
//  IMIHLPassword.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 12/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
//#import "TextFieldValidator.h"
#import "TextFieldValidator.h"
#import "IMIHLRestService.h"
#import "IMIHLDashboardVC.h"

@interface IMIHLPassword : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet TextFieldValidator *oldpasswrd_txtfld;
@property (strong, nonatomic) IBOutlet TextFieldValidator *newpasswrd_txtfld;
@property (strong, nonatomic) IBOutlet TextFieldValidator *reenterpasswrd_txtfld;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backBarBtn;
@property (strong, nonatomic) IBOutlet UIButton *changePasswordBtn;
@property (strong, nonatomic) NSString*patientid_str;
@property (strong, nonatomic) NSString*patientname_str;
- (IBAction)backBarClick:(id)sender;
- (IBAction)changePasswordBtnClick:(id)sender;

@end
