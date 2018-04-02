//
//  ViewController.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 17/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"
#import "IMIHLLogin.h"
#import "IMIHLRecentActivities.h"
@interface ViewController : UIViewController<NIDropDownDelegate,UITableViewDataSource,UITableViewDelegate>{
NIDropDown *dropDown;
}
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;

@property (strong, nonatomic) IBOutlet UIButton *bookAppointmentBtn;
@property(strong,nonatomic)NSString*patientId;
@property (strong, nonatomic) IBOutlet UITableView *testlist_tblview;
@property (strong, nonatomic) IBOutlet UIButton *dropdown_btn;
@property (strong, nonatomic) IBOutlet UIButton *leftsidemenu_btn;
@property (retain,nonatomic) IMIHLLogin*userLogin;
@property (retain,nonatomic)IMIHLRecentActivities *activityObj;
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername;
- (IBAction)leftSideMenuItemClicked:(id)sender;
- (IBAction)rightSideDropDownClicked:(id)sender;
- (IBAction)refreshTouch:(id)sender;
- (IBAction)searchTouch:(id)sender;
- (IBAction)bookAppointmentTouch:(id)sender;

@end

