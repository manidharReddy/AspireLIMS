//
//  LeftSlideMenuTableViewController.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 17/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "ViewController.h"
@interface LeftSlideMenuTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (readwrite , nonatomic) NSString*patientId;
@property (readwrite , nonatomic) NSString*patientName;
@property (readwrite , nonatomic) NSString*patientEmail;
@property (strong, nonatomic) IBOutlet UIImageView *userprofileImgView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLble;
@property (strong, nonatomic) IBOutlet UILabel *userEmailLble;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite , nonatomic) UIImage*profileImage;
@end
