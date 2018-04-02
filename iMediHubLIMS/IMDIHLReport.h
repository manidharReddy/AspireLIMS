//
//  IMDIHLReport.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 29/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "PNChartDelegate.h"
#import "PNChart.h"

//#import "UUChart.h"
@interface IMDIHLReport : UIViewController<PNChartDelegate,UITableViewDelegate,UITableViewDataSource>{
   
}
@property (strong, nonatomic) IBOutlet UITableView *reporttblView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *myreportbarbtnitem;
@property (strong, nonatomic) IBOutlet UILabel *reportsdate_lbl;
@property (strong, nonatomic) IBOutlet UILabel *deptName_lbl;
@property (strong, nonatomic) IBOutlet UILabel *testName_lbl;
//@property (nonatomic) PNBarChart * barChart;
@property (strong, nonatomic) IBOutlet PNBarChart *barChart;
//@property (nonatomic) PNLineChart * lineChart;
@property (strong, nonatomic) IBOutlet PNLineChart *lineChart;

@property (strong, nonatomic) IBOutlet UITableView *reports_tblview;

@property(nonatomic,retain) NSString* selected_index;

@property(nonatomic,retain) NSString* departmentname_str;
@property(nonatomic,retain) NSString* patientid_str;
@property (strong,nonatomic) NSDictionary*tempreportdict;
@property (strong, nonatomic) NSString*filterdateshow_str;
@property(nonatomic,retain) NSMutableArray*patienttestid_arr;
@property(nonatomic,retain) NSMutableArray*patienttestrange_arr;
@property(nonatomic,retain) NSMutableArray*patienttestdate_arr;
@property(nonatomic,retain) NSMutableArray*patienttesttime_arr;
@property(nonatomic,retain)NSMutableArray*patientteststatus_arr;
@property(nonatomic,retain)NSMutableArray*patienttestunits_arr;
@property(nonatomic,retain)NSMutableArray*patienttestname_arr;
@property(nonatomic,retain)NSMutableArray*patienttesttype_arr;
@property(nonatomic,retain)NSMutableArray*patientgrouptestname_arr;
@property(nonatomic,retain)NSMutableArray*patientpaneltestname_arr;
@property(nonatomic,retain)NSMutableArray*patienttestminvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestmaxvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestisready;
-(void)allocateArray;
- (IBAction)changeReportDateClick:(id)sender;
- (IBAction)myReportBackClick:(id)sender;

@end
