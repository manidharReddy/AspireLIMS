//
//  ForgotPasswordVC.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 23/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "TextFieldValidator.h"
#import "IMIHLNewPasswordVC.h"
@interface ForgotPasswordVC : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backarrowbutton;
@property (strong, nonatomic) IBOutlet UIImageView *email_icon_imgview;
@property (strong, nonatomic) IBOutlet TextFieldValidator *email_txtfeild;
- (IBAction)backToSigntouch:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *getPasswordBtn;

@property (strong,nonatomic)NSString*userid_str;
@property (strong,nonatomic)NSString*patientid_str;
- (IBAction)requestpasswrdClick:(id)sender;
- (IBAction)backArrowLeftClick:(id)sender;

@end
