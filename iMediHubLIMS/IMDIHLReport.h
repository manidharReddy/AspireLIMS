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
#import "ALTest.h"

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
@property(nonatomic,retain) NSString* testId;

@property(nonatomic,strong) NSMutableArray<ALTest*>*listOfTests;


- (IBAction)changeReportDateClick:(id)sender;
- (IBAction)myReportBackClick:(id)sender;

@end
