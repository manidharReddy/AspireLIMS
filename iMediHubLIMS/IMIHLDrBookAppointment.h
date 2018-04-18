//
//  IMIHLDrBookAppointment.h
//  iMediHubLIMS
//
//  Created by ihub on 12/21/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"


@interface IMIHLDrBookAppointment : UIViewController<UITableViewDataSource,UITableViewDelegate,kDropDownListViewDelegate>





@property (weak, nonatomic) IBOutlet UITableView *specialities_TableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backarrowbutton;

@property (strong, nonatomic) IBOutlet UIImageView *email_icon_imgview;

//@property (strong, nonatomic)NSArray*testnamelist_arr;
@property (strong, nonatomic) NSString*patientid_str;
@property (strong, nonatomic) NSString*locationid_str;
@property (strong, nonatomic) NSString*deptid_str;
@property (strong, nonatomic)NSArray*locationnamelist_arr;
@property (strong, nonatomic)NSArray*locationidlist_arr;
@property (strong, nonatomic) NSString*specialityname_str;
@property (strong, nonatomic)NSArray*specialitynamelist_arr;
@property (strong, nonatomic)NSArray*deptidlist_arr;
@property (strong, nonatomic) NSString*locationname_str;
@property (strong, nonatomic)DropDownListView * Dropobj;
@property (strong, nonatomic) IBOutlet UIButton *location_dropbtn;
- (IBAction)selectLocationClick:(id)sender;
- (IBAction)backArrowLeftClick:(id)sender;

@end
