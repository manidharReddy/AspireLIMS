//
//  IMDIHDrPrAppnts.h
//  iMediHubLIMS
//
//  Created by ihub on 06/06/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"

@interface IMDIHDrPrAppnts : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *apntmentTblView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backarrowbarbtn;
@property (strong, nonatomic) NSString*patientname_str;

@property (strong, nonatomic) NSString*patientid_str;

- (IBAction)backArrowClick:(id)sender;

@end
