//
//  IMIHLLoginViewController.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 17/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "IMIHLRestService.h"
@interface IMIHLLoginViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *usernameicon;
@property (strong, nonatomic) IBOutlet UIImageView *passwordicon;
@property (strong, nonatomic) IBOutlet UITextField *username_txtfld;
@property (strong, nonatomic) IBOutlet UITextField *usrpasswrd_txt;
@property (strong, nonatomic) NSString*patientid_str;
@property (strong, nonatomic) NSString*patientname_str;
@property (strong, nonatomic) IBOutlet UIImageView *background_img;
@property (strong, nonatomic) IBOutlet UIButton *signInBtn;

- (IBAction)loginClick:(id)sender;

@end
