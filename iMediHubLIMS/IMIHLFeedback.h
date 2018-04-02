//
//  IMIHLFeedback.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 12/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "DropDownListView.h"
@interface IMIHLFeedback : UIViewController<kDropDownListViewDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backbarItem;
@property (strong, nonatomic) IBOutlet UITextView *feedback_txtview;
@property (strong, nonatomic) NSString*patientid_str;
@property (strong, nonatomic) NSString*patientname_str;
@property (strong, nonatomic)DropDownListView * Dropobj;
@property (strong, nonatomic) NSString*feedbcktype_str;
@property (strong, nonatomic) IBOutlet UIButton *feedtypbtn;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
@property (strong, nonatomic) NSArray*feedbcktype_arr;
- (IBAction)feedtypeButtonClick:(id)sender;

- (IBAction)backBarClick:(id)sender;
- (IBAction)sendButtonClick:(id)sender;

@end
