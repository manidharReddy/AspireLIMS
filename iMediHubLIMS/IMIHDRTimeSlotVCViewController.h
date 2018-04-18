//
//  IMIHDRTimeSlotVCViewController.h
//  iMediHubLIMS
//
//  Created by ihub on 23/03/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
#import "IMIHDDoctorTimes.h"
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"

@interface IMIHDRTimeSlotVCViewController : UIViewController<FSCalendarDataSource, FSCalendarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UIView *dr_view;
@property (strong, nonatomic) IBOutlet UICollectionView *collectrionview;
@property (strong, nonatomic) IBOutlet UIView *showTimesInView;
@property (strong, nonatomic) IBOutlet UIButton *rightArrowBtn;
@property (strong, nonatomic) IBOutlet UIButton *leftArrowBtn;
@property (strong, nonatomic) IBOutlet UIButton *bookappt_btn;
@property (strong, nonatomic) IBOutlet UILabel *drtime_lb;
@property (strong, nonatomic) IBOutlet UILabel *dr_name;
@property (strong,nonatomic) NSString*dr_img_str;
@property (strong,nonatomic) NSString*dr_name_str;
@property (strong, nonatomic) IBOutlet UIImageView *dr_imageview;
@property (strong, nonatomic) IBOutlet FSCalendar *fscalender;
@property (strong,nonatomic) IMIHDDoctorTimes*timeslotobj;
- (IBAction)bookClicked:(id)sender;
- (IBAction)leftArrowClick:(id)sender;
- (IBAction)rightArrowClick:(id)sender;
@property (strong, nonatomic) NSString*doctid_str;




@property (strong,nonatomic) NSString*apptdate_str;
@property (strong,nonatomic) NSString*appttime_str;

@property (strong,nonatomic) NSString*patientid_str;




@end
