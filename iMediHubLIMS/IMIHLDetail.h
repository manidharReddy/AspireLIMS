//
//  IMIHLDetail.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 20/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "ALGroup.h"
@interface IMIHLDetail : UIViewController<UITableViewDelegate,UITableViewDataSource>{
bool isback;
}
@property (strong, nonatomic) IBOutlet UITableView *detailreports_tblview;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backbaritem_btn;
@property (strong,nonatomic) NSArray*testdata_arr;
@property (strong, nonatomic) IBOutlet UITableView *detailreport_tblview;
//@property (strong,nonatomic) NSArray*testdata_arr;
@property(nonatomic,retain)NSDictionary*testdict;
@property(nonatomic,retain)NSMutableArray*grouptestname_arr;
@property (strong, nonatomic) NSString*navigation_name_str;
@property (strong, nonatomic) NSString*patientid_str;
@property(nonatomic,retain)NSDictionary*paneltest_dict;
@property(nonatomic,retain)NSDictionary*panelgrps_dict;
@property(nonatomic,retain)NSMutableArray*grpreloadtests_arr;
@property (strong,nonatomic) NSDictionary*tempreportdict;
@property (strong, nonatomic) NSString*filterdateshow_str;
@property (strong, nonatomic) ALGroup*groupObj;
- (IBAction)backItemClick:(id)sender;

@end
