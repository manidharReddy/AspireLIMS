//
//  IMIHLDoctorsList.h
//  iMediHubLIMS
//
//  Created by ihub on 12/21/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMIHLDoctorList.h"
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"

@interface IMIHLDoctorsList : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)IMIHLDoctorList*doctobj;
@property (strong,nonatomic) NSMutableArray*doctr_arr;
@property (weak, nonatomic) IBOutlet UITableView *DoctotsList_TableView;
@property (strong, nonatomic)NSArray*specialitynamelist_arr;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backarrowbutton;
@property (strong, nonatomic) NSString*deptid_str;
@property (strong, nonatomic) NSString*doctid_str;
@property (strong, nonatomic) NSString*locid_str;
@property (strong, nonatomic) NSString*locationname_str;
@property (strong, nonatomic) NSString*specialityname_str;
@property (strong,nonatomic) NSString*dr_img_str;
@property (strong,nonatomic) NSString*dr_name_str;
@property (strong, nonatomic) NSString*patientid_str;
//@property (strong, nonatomic) IBOutlet UIImageView *email_icon_imgview;

- (IBAction)backArrowLeftClick:(id)sender;
@end
