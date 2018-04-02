//
//  DashboardVC.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 18/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"

@interface IMIHLDashboardVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,NIDropDownDelegate>{
NSArray * dropdwn_arr;
}
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UIButton *searchReportsClick;
@property (strong, nonatomic) IBOutlet UILabel *patient_name_lbl;
@property (strong, nonatomic) IBOutlet UICollectionView *dashboard_collection;
@property (strong, nonatomic) IBOutlet UIButton *drop_down_btn;
@property (strong, nonatomic) NSString*patientid_str;
@property (strong, nonatomic) NSString*patientname_str;
- (IBAction)searchReportBtnClick:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *copyright_lbl;

- (IBAction)dropDownClick:(id)sender;
- (IBAction)searchBtnClick:(id)sender;

@end
