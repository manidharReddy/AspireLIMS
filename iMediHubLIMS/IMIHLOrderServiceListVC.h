//
//  IMIHLOrderServiceListVC.h
//  AspireLIMS
//
//  Created by ihub on 27/02/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMIHLOrderServiceListVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *serviceListTableView;
@property (strong,nonatomic) NSArray*services_arr;
@property (strong,nonatomic) NSString*orderid;
@property (strong,nonatomic) NSString*serviceid;
@end
