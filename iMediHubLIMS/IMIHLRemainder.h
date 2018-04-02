//
//  IMIHLRemainder.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 28/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "IMIHLRemaindersList.h"
@interface IMIHLRemainder : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *remainderBackBarItem;
@property (strong,nonatomic) NSMutableArray*reminderdata_arr;
@property(strong,nonatomic)NSString*patientId;
@property(strong,nonatomic) IMIHLRemaindersList*remList;
- (IBAction)remainderBackBarItemClick:(id)sender;

@end
