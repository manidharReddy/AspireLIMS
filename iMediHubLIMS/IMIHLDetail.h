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

@property (strong, nonatomic) IBOutlet UITableView *detailreport_tblview;


@property (strong,nonatomic)NSMutableArray<ALTest*>*listOfTests;
@property (strong, nonatomic) NSString*navigation_name_str;
@property (strong, nonatomic) NSString*patientid_str;

@property (strong, nonatomic) NSString*filterdateshow_str;
@property (strong, nonatomic) ALGroup*groupObj;
- (IBAction)backItemClick:(id)sender;

@end
