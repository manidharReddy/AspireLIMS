//
//  IMIHLDoctBookingApptVC.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 18/10/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
#import "DropDownListView.h"
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "MBProgressHUD.h"

@interface IMIHLDoctBookingApptVC : UIViewController<FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance,kDropDownListViewDelegate>
@property (strong, nonatomic) IBOutlet FSCalendar *fsCalender;
@property (strong, nonatomic) IBOutlet UITextField *name_txtfeild;
@property (strong, nonatomic) NSMutableArray*deptlist_arr;
@property (strong, nonatomic) NSMutableArray*testlist_arr;
@property (strong, nonatomic) NSMutableArray*docttimes_arr;
@property (strong, nonatomic) DropDownListView * Dropobj;
@property (strong, nonatomic) IBOutlet UIButton *deptBtn;
@property (strong, nonatomic) IBOutlet UIButton *testBtn;
@property (strong, nonatomic) IBOutlet UIButton *bookapntmnt_btn;
@property (strong, nonatomic) IBOutlet UISegmentedControl *timeSegment;
@property (strong, nonatomic) IBOutlet UIButton *leftCalenderBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightCalenderBtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftBarItem;
@property (strong, nonatomic) NSString*apptdate_str;
@property (strong, nonatomic) NSString*testname_str;
@property (strong, nonatomic) NSString*locationname_str;
@property (strong, nonatomic) NSString*locationid_str;
@property (strong, nonatomic) NSString*selectedate_str;
@property (strong, nonatomic) IBOutlet UIButton *location_dropbtn;

@property (strong, nonatomic) NSString*tmpdoctid_str;
@property (strong, nonatomic) NSString*tempdeptid_str;
@property (strong, nonatomic) NSString*tmplocation_str;


@property (strong, nonatomic) NSString*patientname_str;

@property (strong, nonatomic) NSString*patientid_str;

@property (strong, nonatomic) NSString*doctstrtdate_str;
@property (strong, nonatomic) NSString*doctenddate_str;


@property (strong, nonatomic) NSString*deptid_str;
@property (strong, nonatomic) NSString*testnamedb_str;
@property (strong, nonatomic) NSString*doctid_str;
@property (strong, nonatomic)NSArray*deptnamelist_arr;
@property (strong, nonatomic)NSArray*doctidlist_arr;
@property (strong, nonatomic)NSArray*doctnamelist_arr;
@property (strong, nonatomic)NSArray*deptidlist_arr;
@property (strong, nonatomic)NSArray*doctavailbllist_arr;


@property (strong, nonatomic)NSArray*locationnamelist_arr;
@property (strong, nonatomic)NSArray*locationidlist_arr;

- (IBAction)selectLocationClick:(id)sender;

- (IBAction)bookAppointmentClick:(id)sender;
- (IBAction)previousDateClick:(id)sender;
- (IBAction)nextDateClick:(id)sender;
- (IBAction)selectDeptClick:(id)sender;
- (IBAction)selectTestClick:(id)sender;
- (IBAction)leftBarBtnClick:(id)sender;

@end
