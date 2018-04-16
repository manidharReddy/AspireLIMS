//
//  IMIHDRTimeSlotVCViewController.m
//  iMediHubLIMS
//
//  Created by ihub on 23/03/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHDRTimeSlotVCViewController.h"
#import "IMIHLRestService.h"

@interface IMIHDRTimeSlotVCViewController ()

@end

@implementation IMIHDRTimeSlotVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getDoctorTimesByDatesService];
    [self setCalenderView];
    [self setDoctProfile];
    [self.bookappt_btn setImage:[UIImage imageWithIcon:@"fa-calendar" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
    //self.showTimesInView.hidden=YES;
    self.dr_view.layer.borderWidth=2;
    self.dr_view.layer.borderColor=[UIColor grayColor].CGColor;
    
}
-(void)getDoctorTimesByDatesService{
    //NSLog(@"DoctorTimesByDatesService");
    IMIHLRestService*timerest = [IMIHLRestService getSharedInstance];
    if ([timerest getDoctorsTimes:_doctid_str]==200) {
      self.timeslotobj = [[IMIHDDoctorTimes alloc]init];
        //NSLog(@"timeslotobj rest dfgg:%@",timerest.restresult_dict);
        
        self.timeslotobj= [self.timeslotobj getDoctorTimesResult:timerest.restresult_dict];
         //NSLog(@"self.timeslotobj.drdatewisetimes_dict:%@",self.timeslotobj.drdatewisetimes_dict);
        ////NSLog(@"arrays times:%@",self.timeslotobj.drtimes_arr);
    }
}

-(void)setCalenderView{
    self.fscalender.dataSource=self;
    self.fscalender.delegate=self;
    //self.fscalender.scope = FSCalendarScopeWeek;
    //self.fsCalender.minimumDate = [NSDate date];
    // self.fsCalender.minimumDateForCalendar =
    self.fscalender.appearance.headerMinimumDissolvedAlpha = 0;
    self.fscalender.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    [_fscalender selectDate:[NSDate date]];
    
    self.showTimesInView.layer.borderWidth=2.0f;
    self.showTimesInView.layer.borderColor =[UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1].CGColor;
    self.bookappt_btn.backgroundColor = [UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1];
}
-(void)setDoctProfile{
    self.dr_imageview.layer.borderWidth=2;
[self.dr_imageview setImage:[UIImage imageWithData:[[NSData alloc]initWithBase64EncodedString:self.dr_img_str options:0]]];
    self.dr_name.text = self.dr_name_str;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //NSLog(@"touchview:%@",touch.view);
    if ([touch.view isKindOfClass:[UIView class]]) {
         // self.showTimesInView.hidden=YES;
    }
}

#pragma mark - FSCalender Methods
- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    //_calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    //NSLog(@"did select date %@",[calendar stringFromDate:date format:@"dd-MM-yyyy"]);
    
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[calendar stringFromDate:date format:@"yyyy-MM-dd"]];
    }];
    
    self.apptdate_str = [NSString stringWithFormat:@"%@",[selectedDates objectAtIndex:0]];
    //NSLog(@"selected dates is %@",selectedDates);
    //NSLog(@"self.timeslotobj.drdatewisetimes_dict:%@",self.timeslotobj.drdatewisetimes_dict);
    [self.timeslotobj getTimeSlotByDate:[self.timeslotobj.drdatewisetimes_dict objectForKey:[selectedDates objectAtIndex:0]]];
    [self.collectrionview reloadData];
    
    }

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    //NSLog(@"%s %@", __FUNCTION__, [calendar stringFromDate:calendar.currentPage]);
}
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar{
    
    return [NSDate date];
}

-(NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    //formatter.dateFormat = @"dd-MM-YYYY";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    //NSLog(@"self.timeslotobj.drdates_arr:%@",self.timeslotobj.drdates_arr);
    //NSString*strdate = [self.timeslotobj.drdates_arr objectAtIndex:self.self.timeslotobj.drdates_arr.count-1];
    NSString*strdate = [self.timeslotobj.drdates_arr objectAtIndex:0];
    //NSLog(@"strdate dr dates:%@",strdate);
    NSDate*tempdate=[formatter dateFromString:strdate];
    //NSLog(@" dr datestempdate:%@",tempdate);
    return tempdate;
    
}

# pragma mark - UICollectionView delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.timeslotobj.drtimes_arr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"timesshow_cell";
        //NSLog(@"cellforitem");
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1]
.CGColor;


    //cell.layer.borderWidth=0.5;
    // cell.frame = CGRectMake(cell.frame.origin.x+10, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    UILabel*timeslbl = (UILabel*)[cell viewWithTag:99];
    

    timeslbl.text =[self.timeslotobj.drtimes_arr objectAtIndex:indexPath.row];
    //NSLog(@"flag time:%@",[self.timeslotobj.drtimeflag_arr objectAtIndex:indexPath.row]);
    if ([[self.timeslotobj.drtimeflag_arr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        //NSLog(@"zero ");
        timeslbl.textColor = [UIColor colorWithRed:50.0/255.0 green:205.0/255.0 blue:50.0/255.0 alpha:1];
        
    }else{
        //NSLog(@"One ");
        timeslbl.textColor = [UIColor grayColor];
        timeslbl.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    }
    [timeslbl setFont:[UIFont systemFontOfSize:cell.bounds.size.width/6]];
        //NSLog(@"cell width:%f",cell.frame.size.width);
    
    if (cell.selected) {
        cell.backgroundColor = [UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1]; // highlight selection
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor]; // Default color
    }
    
    
       return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        return CGSizeMake(collectionView.frame.size.width*0.25, collectionView.frame.size.height*0.3);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return collectionView.bounds.size.width/25;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return collectionView.bounds.size.height/20;
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"de selcte");
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //NSInteger tag = cell.tag;
    //NSLog(@"%d",(int)indexPath.row);
    if ([[self.timeslotobj.drtimeflag_arr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        
   // self.showTimesInView.hidden=YES;
        self.appttime_str = [NSString stringWithFormat:@"%@",[self.timeslotobj.drtimes_arr objectAtIndex:indexPath.row]];
    }else{
        
    }

    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1];
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)bookClicked:(id)sender {
    //NSLog(@"bookclicked");
    self.apptdate_str = [NSString stringWithFormat:@"%@%@%@",self.apptdate_str,@" ",@"00:00:00"];
    IMIHLRestService*apptrest = [IMIHLRestService getSharedInstance];
    /*
    if ([apptrest createDoctorAppointment:self.apptdate_str appointmentTime:self.appttime_str doctorId:self.doctid_str patientId:self.patientid_str]==200) {
        [self showAlertController:@"SuccesFully Booked"];
    }else{
    
    }
     */
    
}
-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Doctor Booking!"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:alrtmsg
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"OK"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    [alert addAction:button0];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)leftArrowClick:(id)sender {
}

- (IBAction)rightArrowClick:(id)sender {
}
@end
