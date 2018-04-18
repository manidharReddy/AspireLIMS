//
//  IMIHLOrdersVC.h
//  iMediHubLIMS
//
//  Created by ihub on 1/5/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMIHLOrdersList.h"
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "MBProgressHUD.h"
#import "ALOrders.h"
@interface IMIHLOrdersVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *orders_tblview;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backItemBar;
@property (strong, nonatomic) NSString*patientid_str;
@property (strong, nonatomic) NSString*orderid_str;
@property (assign, nonatomic) BOOL isFileReady;
@property (weak, nonatomic) NSString*pdfname;
@property  (strong,nonatomic)IMIHLOrdersList*orderlist_obj;
@property (strong, nonatomic) ALOrders*ordersObj;
- (IBAction)backBarItemClick:(id)sender;

@end
