//
//  IMIHLReport.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 19/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NIDropDown.h"
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "IMIHLDetail.h"
#import "IMIHLRestService.h"
#import "MBProgressHUD.h"
@interface IMIHLReport : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    int indexvalue;
}
@property (strong, nonatomic) IBOutlet UIButton *changebtn;

@property (strong, nonatomic) NSString*patientid_str;
@property (strong, nonatomic) NSString*id_str;
@property (strong, nonatomic) NSString*calledchg_str;
@property (strong, nonatomic) NSString*todate_str;
@property (strong, nonatomic) NSString*fromdate_str;
@property (strong, nonatomic) NSString*navigation_name_str;
@property (strong, nonatomic) IBOutlet UILabel *dateshow_lbl;
@property (strong, nonatomic) NSString*datestore_str;
@property (strong, nonatomic) IBOutlet UITableView *labrprt_tblview;
@property (strong, nonatomic) IBOutlet UIButton *graph_btn;
@property (strong,nonatomic) NSDictionary*tempreportdict;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backBaritem;
-(void)restServiceCall:(NSString*)patientid :(NSString*)todate :(NSString*)fromdate;
- (IBAction)backBtnClick:(id)sender;
- (IBAction)changeButtonClick:(id)sender;


@end
