//
//  IMIHLNewPasswordVC.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 08/08/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "IMIHLRestService.h"

@interface IMIHLNewPasswordVC : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet TextFieldValidator *newpasswrd_txtfield;
@property (strong, nonatomic) IBOutlet TextFieldValidator *reenterpasswrd_txtfield;
@property (strong, nonatomic) IBOutlet UIImageView *newpassicon_imgview;
@property (strong, nonatomic) IBOutlet UIImageView *confirmpasswrd_imageview;
@property (strong,nonatomic)NSString*userid_str;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong,nonatomic)NSString*patientid_str;
@property (strong, nonatomic) IBOutlet UIButton *backarrowbutton;
- (IBAction)backArrowLeftClick:(id)sender;
- (IBAction)resetpasswrdClick:(id)sender;

@end
