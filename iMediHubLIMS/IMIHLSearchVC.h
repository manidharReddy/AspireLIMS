//
//  IMIHLSearchVC.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 01/08/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "DropDownListView.h"
@interface IMIHLSearchVC : UITableViewController<UISearchBarDelegate,kDropDownListViewDelegate>
@property (strong, nonatomic) NSString*patientid_str;
@property(strong,nonatomic) NSMutableArray*serviceid_arr;
@property(strong,nonatomic) NSMutableArray*servicename_arr;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backbarbtnitem;
@property (strong, nonatomic)DropDownListView * Dropobj;
- (IBAction)backbaritemClick:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;
@property (strong,nonatomic)NSString*servicename_str;

@end
