//
//  IMIHLAppointmentsTableViewController.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 12/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"

@interface IMIHLAppointmentsTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *apntmentTblView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backarrowbarbtn;
@property (strong, nonatomic) NSString*patientname_str;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

@property (strong, nonatomic) NSString*patientid_str;
@property (strong, nonatomic) NSString*reason_str;
@property (strong, nonatomic) NSString*apptnID_str;
@property (strong, nonatomic) NSString*isCancle_str;
- (IBAction)backArrowClick:(id)sender;
- (IBAction)submitClick:(id)sender;
- (IBAction)cancel:(id)sender;

@end
