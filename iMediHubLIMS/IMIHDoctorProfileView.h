//
//  IMIHDoctorProfileView.h
//  iMediHubLIMS
//
//  Created by ihub on 12/23/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"

@interface IMIHDoctorProfileView : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray*doctr_arr;
@property (strong, nonatomic) NSString*specialityname_str;
@property (weak, nonatomic) IBOutlet UIImageView *doctor_profile_bgimgview;
@property (weak, nonatomic) IBOutlet UIImageView *doctor_profile_pic_imgview;
@property (weak, nonatomic) IBOutlet UILabel *doctor_name_lbl;
@property (weak, nonatomic) IBOutlet UILabel *doctor_studies_lbl;
@property (weak, nonatomic) IBOutlet UILabel *doctor_specilization_lbl;
@property (weak, nonatomic) IBOutlet UITableView *doctor_tblview;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backarrowbutton;
- (IBAction)backArrowLeftClick:(id)sender;
@end
