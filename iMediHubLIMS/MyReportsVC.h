//
//  MyReportsVC.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 24/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "FSCalendar.h"
#import "DropDownListView.h"
//#import "CalendarView.h"
@interface MyReportsVC : UIViewController<FSCalendarDataSource, FSCalendarDelegate,kDropDownListViewDelegate>
//@property (strong, nonatomic) IBOutlet CalendarView *calenderView;
@property (strong, nonatomic) IBOutlet UIButton *checkAvailableReportsBtn;
@property (strong, nonatomic) NSString*calledchg_str;
@property (strong, nonatomic) IBOutlet FSCalendar *fsCalender;
@property (strong, nonatomic) IBOutlet UIButton *leftCalenderBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightCalenderBtn;
@property (strong, nonatomic) IBOutlet UIButton *selectDeptBtn;
@property (strong, nonatomic) IBOutlet UIButton *selectTestBtn;
@property (strong, nonatomic) NSString*todate_str;
@property (strong, nonatomic) NSString*fromdate_str;
@property (strong, nonatomic) NSString*todateformate_str;
@property (strong, nonatomic) NSString*fromdateformate_str;

@property (strong, nonatomic) NSString*deptid_str;
@property (strong, nonatomic) NSString*testid_str;
@property (strong, nonatomic)NSArray*deptnamelist_arr;
@property (strong, nonatomic)NSArray*testidlist_arr;
@property (strong, nonatomic)NSArray*testnamelist_arr;
@property (strong, nonatomic)NSArray*deptidlist_arr;
@property (strong, nonatomic) NSString*patientid_str;
@property (strong,nonatomic) NSDictionary*tempreportdict;
//@property (strong,nonatomic) NSDictionary*tempreportdict;
@property (strong, nonatomic) NSString*filterdateshow_str;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *myreportsbackItem_btn;
- (IBAction)myReportsBackClick:(id)sender;
- (IBAction)previuosDateClick:(id)sender;
- (IBAction)nextDateClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *fromdate_btn;
@property (strong, nonatomic) IBOutlet UIView *calendarPopView;
@property (strong, nonatomic) IBOutlet UIButton *todate_btn;
- (IBAction)fromDateClick:(id)sender;
- (IBAction)toDateClick:(id)sender;
- (IBAction)selectDeparmentClick:(id)sender;
- (IBAction)selectTestClick:(id)sender;
- (IBAction)serachReportsClick:(id)sender;
- (IBAction)closePopUpClick:(id)sender;

@end
