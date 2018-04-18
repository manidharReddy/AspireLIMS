//
//  IMIHLEditProfileVC.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 23/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "TextFieldValidator.h"
#import "MBProgressHUD.h"
#import "IMIHLLogin.h"
@interface IMIHLEditProfileVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property (strong,nonatomic)NSData*imagedata;
@property (strong,nonatomic)NSString*image_str;
@property (strong,nonatomic) NSString*genderstr;
@property (strong, nonatomic) IBOutlet TextFieldValidator *firstname_txtfld;
//@property (strong,nonatomic) UIImage *chosenImage;
//@property (strong,nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSString*firstname_str;
@property (strong, nonatomic) NSString*lastname_str;
@property (strong, nonatomic) NSString*emailid_str;
@property (strong, nonatomic) NSString*dob_str;
@property (strong, nonatomic) NSString*pageid_str;
@property (weak, nonatomic) IBOutlet UIButton *update_btn;

@property (strong, nonatomic) IBOutlet UIButton *genderflag_btn;
@property (strong, nonatomic) IBOutlet TextFieldValidator *dob_txtfld;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backbarbtn;
@property (strong, nonatomic) IBOutlet TextFieldValidator *emailid_txtfld;
@property (strong, nonatomic) IBOutlet UIButton *genderflagfmail_btn;
@property (strong, nonatomic) IBOutlet TextFieldValidator *patientname_txtfld;
@property (strong, nonatomic) IBOutlet UIButton *profilepicupload_btn;
@property (strong, nonatomic) IBOutlet UIButton *maleicon_btn;
@property (strong, nonatomic) IBOutlet UIButton *femaleicon_btn;
@property (strong, nonatomic) NSString*patientid_str;
@property (strong, nonatomic) IMIHLLogin*loginInfo;
- (IBAction)profileImageUploadClick:(id)sender;
- (IBAction)genderMaleClick:(id)sender;
- (IBAction)genderFemaleClick:(id)sender;
- (IBAction)submit:(id)sender;
- (IBAction)backButtonClick:(id)sender;

@end
