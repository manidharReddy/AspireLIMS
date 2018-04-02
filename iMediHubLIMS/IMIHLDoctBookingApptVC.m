//
//  IMIHLDoctBookingApptVC.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 18/10/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLDoctBookingApptVC.h"
#import "IMIHDDepartments.h"
//#import "IMIHLTest.h"
#import "IMIHLDoctorList.h"
#import "IMIHLRestService.h"
#import "IMIHLAppointmentsTableViewController.h"
#import "IMIHLDBManager.h"
#import "IMIHDLocations.h"
#import "IMIHLDoctorDates.h"
#import "IMIHLDoctorTimings.h"

@import EventKit;

@interface IMIHLDoctBookingApptVC (){
BOOL dropdownflagone,dropdownflagtwo,dropdownflaglocation;
}
// The database with calendar events and reminders
@property (strong, nonatomic) EKEventStore *eventStore;

// Indicates whether app has access to event store.
@property (nonatomic) BOOL isAccessToEventStoreGranted;

// The data source for the table view
@property (strong, nonatomic) NSMutableArray *todoItems;

@property (strong, nonatomic) EKCalendar *calendar;
@property (copy, nonatomic) NSArray *reminders;


@end

@implementation IMIHLDoctBookingApptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.leftBarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    //[self setDepartmentList];
    //[self setTestList];
    //[self setCalenderView];
    [self getLocationList];
    //[self getDepartmentList];
    self.name_txtfeild.text = self.patientname_str;
    self.name_txtfeild.enabled=NO;
    [self updateAuthorizationStatusToAccessEventStore];
    
    // [self.leftCalenderBtn setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] ];
    // [self.leftCalenderBtn setImage:[UIImage imageWithIcon:@"fa-chevron-circle-left" backgroundColor:[UIColor redColor] iconColor:[UIColor whiteColor] fontSize:20] forState:UIControlStateNormal];
    
    // [self.rightCalenderBtn setImage:[UIImage imageWithIcon:@"fa-chevron-circle-right" backgroundColor:[UIColor redColor] iconColor:[UIColor whiteColor] fontSize:20] forState:UIControlStateNormal];
    
    // [self.bookapntmnt_btn setImage:[UIImage imageWithIcon:@"fa-calendar-check-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
    
    [self.leftCalenderBtn setImage:[UIImage imageWithIcon:@"fa-chevron-circle-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
    
    
    [self.rightCalenderBtn setImage:[UIImage imageWithIcon:@"fa-chevron-circle-right" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
    
    [self.bookapntmnt_btn setImage:[UIImage imageWithIcon:@"fa-calendar" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];

}
-(void)getDepartmentList:(NSString*)locationid{
    
    IMIHLRestService*restgetdept = [IMIHLRestService getSharedInstance];
    int statuscode =[restgetdept getDoctorDepartments:locationid];
    if (statuscode==200) {
        //NSLog(@"status of departments:%@",restgetdept.restresult_dict);
        IMIHDDepartments*deptobj = [[IMIHDDepartments alloc]init];
        deptobj = [deptobj getDepartmentResult:restgetdept.restresult_dict];
        //NSLog(@"deptobj:%@",deptobj.deptid_arr);
        self.deptidlist_arr = deptobj.deptid_arr;
        self.deptnamelist_arr = deptobj.deptname_arr;
    }else if(statuscode==0){
        [self showAlertController:@"No Network Connection"];
    }else{
        //NSLog(@"Error Message:%@",[restgetdept.restresult_dict objectForKey:@"msg"]);
    }
}
-(void)getLocationList{
    
    IMIHLRestService*restgetdept = [IMIHLRestService getSharedInstance];
    int statuscode =[restgetdept getDoctorLocations:self.patientid_str];
    if (statuscode==200) {
        //NSLog(@"status of departments:%@",restgetdept.restresult_dict);
        IMIHDLocations*locationobj = [[IMIHDLocations alloc]init];
        locationobj = [locationobj getLocationResult:restgetdept.restresult_dict];
        //NSLog(@"locationobjarr:%@",locationobj.locatid_arr);
        self.locationidlist_arr = locationobj.locatid_arr;
        self.locationnamelist_arr = locationobj.locatname_arr;
        
    }else if(statuscode==0){
        [self showAlertController:@"No Network Connection"];
    }else{
        //NSLog(@"Error Message:%@",[restgetdept.restresult_dict objectForKey:@"msg"]);
    }
}

-(void)getDepartmentDoctorList{
    /*
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";
    if ([self.doctid_str isEqual:[NSNull null]]||self.doctid_str==nil) {
        IMIHLRestService*restgetdeptdocts = [IMIHLRestService getSharedInstance];
        int statuscode =[restgetdeptdocts getDoctorsList:self.deptid_str];
        if (statuscode==200) {
            //NSLog(@"status of  doctor list:%@",restgetdeptdocts.restresult_dict);
           IMIHLDoctorList *doclistobj = [[IMIHLDoctorList alloc]init];
            doclistobj = [doclistobj getLocationResult:restgetdeptdocts.restresult_dict];
            self.doctidlist_arr = doclistobj.doctid_arr;
            //NSLog(@"testid:%@",doclistobj.doctid_arr);
            self.doctnamelist_arr = doclistobj.doctname_arr;
            //NSLog(@"testobj.testname_arr:%@",doclistobj.doctname_arr);
        }else if(statuscode==0){
            [self showAlertController:@"No Network Connection"];
        }else{
            self.doctnamelist_arr=nil;
            //NSLog(@"Error Message:%@",[restgetdeptdocts.restresult_dict objectForKey:@"msg"]);
        }
    }else{
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
     */
}
 

-(void)getDoctorAvailableDates{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";
    //NSLog(@"getDoctorAvailableDates entred");
    if (![self.doctid_str isEqual:[NSNull null]]||self.doctid_str!=nil) {
        IMIHLRestService*restgetdeptdocts = [IMIHLRestService getSharedInstance];
        int statuscode =[restgetdeptdocts getDoctorsDates:self.doctid_str];
        if (statuscode==200) {
            //NSLog(@"status of getDoctorAvailableDates entred tests:%@",restgetdeptdocts.restresult_dict);
            IMIHLDoctorDates *doclistobj = [[IMIHLDoctorDates alloc]init];
            doclistobj = [doclistobj getDoctorDatesResult:restgetdeptdocts.restresult_dict];
            
            self.doctstrtdate_str = doclistobj.startdate_str;
            self.doctenddate_str = doclistobj.enddate_str;
            self.doctavailbllist_arr = doclistobj.doctavalbl_arr;
            [self setCalenderView];
            //NSLog(@"doctstrtdate_str:%@",doclistobj.startdate_str);
            //self.doctnamelist_arr = doclistobj.doctname_arr;
            //NSLog(@"doclistobj.doctavalbl_arr:%@",doclistobj.doctavalbl_arr);
        }else if(statuscode==0){
            [self showAlertController:@"No Network Connection"];
        }else{
            self.doctavailbllist_arr=nil;
            //NSLog(@"Error Message:%@",[restgetdeptdocts.restresult_dict objectForKey:@"msg"]);
        }
    }else{
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
/*
-(void)getDoctorAvailableTimes{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";
    //NSLog(@"getDoctorAvailableDates entred");
    if (![self.doctid_str isEqual:[NSNull null]]||self.doctid_str!=nil) {
        IMIHLRestService*restgetdeptdocts = [IMIHLRestService getSharedInstance];
        int statuscode =[restgetdeptdocts getDoctorsTimes:self.doctid_str :self.apptdate_str];
        if (statuscode==200) {
            //NSLog(@"status of getDoctorAvailableDates entred tests:%@",restgetdeptdocts.restresult_dict);
            IMIHLDoctorTimings *doclistobj = [[IMIHLDoctorTimings alloc]init];
            doclistobj = [doclistobj getDoctorTimesResult:restgetdeptdocts.restresult_dict];
            
            self.docttimes_arr = doclistobj.doctslottimes_arr;
            
            
            //self.doctnamelist_arr = doclistobj.doctname_arr;
            //NSLog(@"doclistobj.doctslottimes_arr:%@",doclistobj.doctslottimes_arr);
        }else if(statuscode==0){
            [self showAlertController:@"No Network Connection"];
        }else{
            self.doctavailbllist_arr=nil;
            //NSLog(@"Error Message:%@",[restgetdeptdocts.restresult_dict objectForKey:@"msg"]);
        }
    }else{
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

*/

-(void)setCalenderView{
    self.fsCalender.dataSource=self;
    self.fsCalender.delegate=self;
    //self.fsCalender.minimumDate = [NSDate date];
    // self.fsCalender.minimumDateForCalendar =
    self.fsCalender.appearance.headerMinimumDissolvedAlpha = 0;
    self.fsCalender.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    [_fsCalender selectDate:[NSDate date]];
}

-(void)setDepartmentList{
    
    self.deptlist_arr = [[NSMutableArray alloc]init];
    [self.deptlist_arr setArray:@[@"India",@"Swaziland",@"Africa",@"Australlia",@"Pakistan",@"Srilanka",@"Mexico",@"United Kingdom",@"United States",@"Portugal"]];
}
-(void)setTestList{
    self.testlist_arr = [[NSMutableArray alloc]init];
    [self.testlist_arr setArray:@[@"India",@"Swaziland",@"Africa",@"Australlia",@"Pakistan",@"Srilanka",@"Mexico",@"United Kingdom",@"United States",@"Portugal"]];
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
    //NSLog(@"selected dates is %@",selectedDates);
    
    /*
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     //formatter.dateFormat = @"yyyy-MM-dd";
     formatter.dateFormat = @"dd-MM-yyyy";
     formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
     
     self.dob_txtfld.text = [formatter stringFromDate:self.datepicker.date];
     */
    self.apptdate_str = [NSString stringWithFormat:@"%@",[selectedDates objectAtIndex:0]];
    
    [self displayTimings];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    //NSLog(@"%s %@", __FUNCTION__, [calendar stringFromDate:calendar.currentPage]);
}
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar{
    
    if (self.doctavailbllist_arr.count!=0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        //formatter.dateFormat = @"dd-MM-YYYY";
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        // self.dob_txtfld.text = [formatter stringFromDate:self.datepicker.date];
        //NSLog(@"doctavailbllist_arr last date:%@",[self.doctavailbllist_arr objectAtIndex:0]);
        //NSLog(@"datefromstr:%@",[formatter dateFromString:[self.doctavailbllist_arr objectAtIndex:0]]);
        NSString*strdate = [self.doctavailbllist_arr objectAtIndex:0];
        //NSLog(@"strdate minimum date:%@",strdate);
        NSDate*tempdate=[formatter dateFromString:strdate];
        //NSLog(@"tempdate:%@",tempdate);
        return tempdate;
        // return [self.doctavailbllist_arr objectAtIndex:self.doctavailbllist_arr.count-1];
    }
    return [NSDate date];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{
    //NSLog(@"maximudate");
    //NSLog(@"doctor available dates:%@",self.doctavailbllist_arr);
    if (self.doctavailbllist_arr.count!=0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        //formatter.dateFormat = @"dd-MM-YYYY";
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
       // self.dob_txtfld.text = [formatter stringFromDate:self.datepicker.date];
        //NSLog(@"doctavailbllist_arr last date:%@",[self.doctavailbllist_arr objectAtIndex:self.doctavailbllist_arr.count-1]);
        //NSLog(@"datefromstr:%@",[formatter dateFromString:[self.doctavailbllist_arr objectAtIndex:self.doctavailbllist_arr.count-1]]);
        NSString*strdate = [self.doctavailbllist_arr objectAtIndex:self.doctavailbllist_arr.count-1];
        //NSLog(@"strdate:%@",strdate);
        NSDate*tempdate=[formatter dateFromString:strdate];
        //NSLog(@"tempdate:%@",tempdate);
        return tempdate;
        // return [self.doctavailbllist_arr objectAtIndex:self.doctavailbllist_arr.count-1];
    }
    
    return [NSDate date];
}

- (nullable NSArray *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventColorsForDate:(NSDate *)date{
   
    //NSLog(@"multiple datessssssss");
    
    if (self.doctavailbllist_arr.count!=0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        //formatter.dateFormat = @"dd-MM-YYYY";
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        // self.dob_txtfld.text = [formatter stringFromDate:self.datepicker.date];
        //NSLog(@"doctavailbllist_arr last date:%@",[self.doctavailbllist_arr objectAtIndex:self.doctavailbllist_arr.count-1]);
        //NSLog(@"datefromstr:%@",[formatter dateFromString:[self.doctavailbllist_arr objectAtIndex:self.doctavailbllist_arr.count-1]]);
       // NSString*strdate = [self.doctavailbllist_arr objectAtIndex:self.doctavailbllist_arr.count-1];
        //NSLog(@"strdate:%@",strdate);
        //NSDate*tempdate=[formatter dateFromString:strdate];
        //NSLog(@"tempdate:%@",tempdate);
        //return tempdate;
        // return [self.doctavailbllist_arr objectAtIndex:self.doctavailbllist_arr.count-1];
    }
    return self.doctavailbllist_arr;
}
/*
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date{
    return [UIColor redColor];
}
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -kDropDown
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    _Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    _Dropobj.delegate = self;
    [_Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [_Dropobj SetBackGroundDropDown_R:0.0 G:108.0 B:194.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    if (dropdownflagone==1) {
        self.deptBtn.titleLabel.text=[self.deptnamelist_arr objectAtIndex:anIndex];
        self.testname_str =[self.deptnamelist_arr objectAtIndex:anIndex];
        self.deptid_str = [self.deptidlist_arr objectAtIndex:anIndex];
    }else if (dropdownflagtwo==1) {
        self.testnamedb_str = [self.doctnamelist_arr objectAtIndex:anIndex];
        self.testBtn.titleLabel.text=[self.doctnamelist_arr objectAtIndex:anIndex];
        self.doctid_str = [self.doctidlist_arr objectAtIndex:anIndex];
        //NSLog(@"testidstrrr:%@",self.doctid_str);
        [self getDoctorAvailableDates];
    }else if (dropdownflaglocation==1) {
        //self.locationid_str =nil;
        self.location_dropbtn.titleLabel.text=[self.locationnamelist_arr objectAtIndex:anIndex];
        self.locationid_str = [self.locationidlist_arr objectAtIndex:anIndex];
        //NSLog(@"locationid:%@",self.locationid_str);
    }
    
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    ///----------------Get Selected Value[Multiple selection]-----------------//
    /*
     if (ArryData.count>0) {
     _lblSelectedCountryNames.text=[ArryData componentsJoinedByString:@"\n"];
     CGSize size=[self GetHeightDyanamic:_lblSelectedCountryNames];
     _lblSelectedCountryNames.frame=CGRectMake(16, 240, 287, size.height);
     }
     else{
     _lblSelectedCountryNames.text=@"";
     }
     */
}

- (void)DropDownListViewDidCancel{
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //NSLog(@"touchview:%@",touch.view);
    if ([touch.view isKindOfClass:[UIView class]]) {
        [_Dropobj fadeOut];
    }
}

-(CGSize)GetHeightDyanamic:(UILabel*)lbl
{
    NSRange range = NSMakeRange(0, [lbl.text length]);
    CGSize constraint;
    constraint= CGSizeMake(288 ,MAXFLOAT);
    CGSize size;
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) {
        NSDictionary *attributes = [lbl.attributedText attributesAtIndex:0 effectiveRange:&range];
        CGSize boundingBox = [lbl.text boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else{
        
        
        size = [lbl.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    }
    return size;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectLocationClick:(id)sender {
    
    
    self.doctnamelist_arr=nil;
    self.doctidlist_arr=nil;
    
    dropdownflagone=0;
    dropdownflagtwo=0;
    dropdownflaglocation=1;
    [_Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Location" withOption:self.locationnamelist_arr xy:CGPointMake(30, self.name_txtfeild.frame.origin.y+50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
    
}

-(void)loaderCall{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Booking....";
    
}

-(void)displayTimings{
    [_Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Slot" withOption:self.docttimes_arr xy:CGPointMake(30, self.name_txtfeild.frame.origin.y+50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
    
}

- (IBAction)bookAppointmentClick:(id)sender {
    //NSLog(@"book an appointment cliked");
    //NSLog(@"aapdate_str:%@,deptid_str:%@,doctid_str:%@",self.apptdate_str,self.deptid_str,self.doctid_str);
    //if(self.apptdate_str!=nil&&self.deptid_str!=nil&&self.doctid_str!=nil){
    if(self.apptdate_str!=nil && self.locationid_str!=nil){
        [self loaderCall];
        [self performSelector:@selector(bookingAppointment) withObject:nil afterDelay:0.1];
    }else if(self.apptdate_str==nil){
        [self showAlertController:[NSString stringWithFormat:@"Please select booking date"]];
    }else if(self.locationid_str==nil){
        [self showAlertController:[NSString stringWithFormat:@"Please select location"]];
    }
    
    /*
     else if(self.deptid_str==nil){
     [self showAlertController:[NSString stringWithFormat:@"Please select department"]];
     }else if(self.doctid_str!=nil){
     [self showAlertController:[NSString stringWithFormat:@"Please select test"]];
     }
     */
}


-(void)bookingAppointment{
    
    
    IMIHLRestService*restcreateappt = [IMIHLRestService getSharedInstance];
    
    if (self.locationid_str!=nil && self.deptid_str==nil && self.doctid_str==nil) {
        //self.locationid_str=@"";
        self.deptid_str=@"";
        self.doctid_str=@"";
    }else if ([self.deptid_str isEqual:[NSNull null]] || [self.doctid_str isEqual:[NSNull null]] || [self.deptid_str isEqualToString:@"(null)"]||[self.doctid_str isEqualToString:@"(null)"]){
        //self.locationid_str=@"";
        self.deptid_str=@"";
        self.doctid_str=@"";
        //self.locationid_str=@"";
    }
    int statuscode =[restcreateappt createAppointment:self.patientid_str :self.apptdate_str :self.locationid_str :self.deptid_str :self.doctid_str];
    if (statuscode==200) {
        //NSLog(@"status of restcreateappt:%@",restcreateappt.restresult_dict);
        //[self showAlertController:@"Successfully sended"];
        
        //NSString*apptid_str =[NSString stringWithFormat:@"%u",[[restcreateappt.restresult_dict objectForKey:@"appontmentId"]integerValue]];
        //NSLog(@"appitment id drd:%@",apptid_str);
        //IMIHLDBManager*dbappnt = [IMIHLDBManager getSharedInstance];
        //[dbappnt deleteAppoinmentsInfoDB];
        //BOOL isSuccess = [dbappnt savePatientAppoinments:apptid_str :self.testnamedb_str :self.apptdate_str :self.deptid_str :@""];
        //if (isSuccess==YES) {
          //  //NSLog(@"Successfully Inserted in appnt DB");
            [self showAlertController:[NSString stringWithFormat:@"You have successfully booked an appointment"]];
            
            
            
            [self addReminderForToDoItem:[NSString stringWithFormat:@"You have an appointment on %@ for %@",self.apptdate_str,self.testname_str]];
            
            self.apptdate_str=nil;
            self.locationid_str=nil;
            self.doctid_str=nil;
            self.deptid_str=nil;
            
            self.deptBtn.titleLabel.text=@"Select Department";
            self.testBtn.titleLabel.text=@"Select Test";
            self.location_dropbtn.titleLabel.text=@"Select Location";
            
            
        //}else{
          //  //NSLog(@"Failed to Insert in appnt DB");
        //}
        
        // [self loadViewControllerFromStoryBoard:@"apntmentsid"];
        
        
    }else if(statuscode==0){
        [self showAlertController:@"No Network Connection"];
    }else{
        //NSLog(@"Error Message:%@",[restcreateappt.restresult_dict objectForKey:@"message"]);
        // [self showAlertController:[restcreateappt.restresult_dict objectForKey:@"message"]];
        [self showAlertController:[NSString stringWithFormat:@"You have failed to book an appointment"]];
    }
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Appointment"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
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


- (IBAction)previousDateClick:(id)sender {
    //NSLog(@"entered in previous page");
    NSDate *currentMonth = self.fsCalender.currentPage;
    NSDate *previousMonth = [self.fsCalender dateBySubstractingMonths:1 fromDate:currentMonth];
    [self.fsCalender setCurrentPage:previousMonth animated:YES];
    
}

- (IBAction)nextDateClick:(id)sender {
    //NSLog(@"entered in next page");
    NSDate *currentMonth = self.fsCalender.currentPage;
    NSDate *nextMonth = [self.fsCalender dateByAddingMonths:1 toDate:currentMonth];
    [self.fsCalender setCurrentPage:nextMonth animated:YES];
    
}

- (IBAction)selectDeptClick:(id)sender {
    //NSLog(@"location id dept:%@",self.locationid_str);
    //self.doctid_str=nil;
    if (self.locationid_str==nil) {
        //NSLog(@"empty");
        [self showAlertController];
    }
    /*
     else if(self.doctidlist_arr==nil && self.deptid_str!=nil){
     //NSLog(@"ifksdjsldkjskdjs");
     }
     */
    else if (self.locationid_str!=nil){
        //NSLog(@"selcted:%@",self.locationid_str);
        if ([self.locationid_str isEqualToString:self.tmplocation_str]) {
            
            //NSLog(@"if condition");
            
        }else {
            
            //NSLog(@"else condition");
            [self getDepartmentList:self.locationid_str];
            self.tmplocation_str = self.locationid_str;
            
        }
        if (self.deptnamelist_arr.count!=0) {
            
            
            dropdownflagone=1;
            dropdownflagtwo=0;
            dropdownflaglocation=0;
            [_Dropobj fadeOut];
            [self showPopUpWithTitle:@"Select Department" withOption:self.deptnamelist_arr xy:CGPointMake(30, self.name_txtfeild.frame.origin.y+50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
        }else{
            [self showAlertController:@"No departments for this location"];
            
        }
    }
    
}

- (IBAction)selectTestClick:(id)sender {
    if (self.deptid_str==nil) {
        //NSLog(@"empty");
        [self showAlertController];
    }//else if ([self.locationid_str isEqualToString:self.tmplocation_str] && [self.doctid_str isEqualToString:self.tmpdoctid_str]){ //if(self.doctidlist_arr==nil && self.deptid_str!=nil){
    else if (self.locationid_str!=nil && self.deptid_str!=nil){
        //NSLog(@"deptid:%@",self.deptid_str);
        //NSLog(@"tempdeptid:%@",self.tempdeptid_str);
        if ([self.deptid_str isEqualToString:self.tempdeptid_str]) {
            
        }else{
            // self.doctidlist_arr=nil;
            self.doctid_str=nil;
            //NSLog(@" if djsk doctidlist_arr:%@",self.doctidlist_arr);
            [self getDepartmentDoctorList];
            //self.tmpdoctid_str = self.doctid_str;
            self.tempdeptid_str = self.deptid_str;
            
        }
        
    }else{
        
        /*
         [_Dropobj fadeOut];
         dropdownflagone=0;
         dropdownflagtwo=1;
         [self showPopUpWithTitle:@"Select Test" withOption:self.doctnamelist_arr xy:CGPointMake(30, self.name_txtfeild.frame.origin.y+50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
         
         */
        
    }
    
    if (self.doctnamelist_arr.count!=0) {
        
        [_Dropobj fadeOut];
        dropdownflagone=0;
        dropdownflagtwo=1;
        [self showPopUpWithTitle:@"Select Test" withOption:self.doctnamelist_arr xy:CGPointMake(30, self.name_txtfeild.frame.origin.y+50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
        
        /*
         else if(self.doctidlist_arr!=nil){
         
         //NSLog(@"doctidlist_arr:%@",self.doctidlist_arr);
         dropdownflagone=0;
         dropdownflagtwo=1;
         
         [self showPopUpWithTitle:@"Select Test" withOption:self.doctnamelist_arr xy:CGPointMake(30, self.name_txtfeild.frame.origin.y+50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
         
         }
         */
        dropdownflaglocation=0;
    }else{
        [self showAlertController:@"No tests for this departments"];
        
    }
    
    
}

-(void)showAlertController{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Test Alert"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:@"Please select department to show tests..!"
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


- (IBAction)leftBarBtnClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"dashboardvc"];
}


#pragma mark - Load ViewControllers
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    if ([identifiername isEqualToString:@"apntmentsid"]) {
        IMIHLAppointmentsTableViewController * pavc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        pavc.patientid_str = self.patientid_str;
        //[self presentViewController:vc animated:YES completion:nil];
        [self.navigationController pushViewController:pavc animated:YES];
    }else{
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        //[self presentViewController:vc animated:YES completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/*Reminder Implementation*/
#pragma mark - Custom accessors

// 1
- (EKEventStore *)eventStore {
    if (!_eventStore) {
        _eventStore = [[EKEventStore alloc] init];
    }
    return _eventStore;
}

- (EKCalendar *)calendar {
    if (!_calendar) {
        
        // 1
        NSArray *calendars = [self.eventStore calendarsForEntityType:EKEntityTypeReminder];
        
        // 2
        NSString *calendarTitle = @"iMediHubLIMS";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title matches %@", calendarTitle];
        NSArray *filtered = [calendars filteredArrayUsingPredicate:predicate];
        
        if ([filtered count]) {
            _calendar = [filtered firstObject];
        } else {
            
            // 3
            _calendar = [EKCalendar calendarForEntityType:EKEntityTypeReminder eventStore:self.eventStore];
            _calendar.title = @"iMediHubLIMS";
            _calendar.source = self.eventStore.defaultCalendarForNewReminders.source;
            
            // 4
            NSError *calendarErr = nil;
            BOOL calendarSuccess = [self.eventStore saveCalendar:_calendar commit:YES error:&calendarErr];
            if (!calendarSuccess) {
                // Handle error
            }
        }
    }
    return _calendar;
}

- (NSMutableArray *)todoItems {
    if (!_todoItems) {
        _todoItems = [@[@"Get Milk!", @"Go to gym", @"Breakfast with Rita!", @"Call Bob", @"Pick up newspaper", @"Send an email to Joe", @"Read this tutorial!", @"Pick up flowers"] mutableCopy];
    }
    return _todoItems;
}



#pragma mark - Reminders

- (void)updateAuthorizationStatusToAccessEventStore {
    // 2
    EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    switch (authorizationStatus) {
            // 3
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted: {
            self.isAccessToEventStoreGranted = NO;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Access Denied"
                                                                message:@"This app doesn't have access to your Reminders." delegate:nil
                                                      cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alertView show];
            //[self.tableView reloadData];
            break;
        }
            
            // 4
        case EKAuthorizationStatusAuthorized:
            self.isAccessToEventStoreGranted = YES;
            //[self.tableView reloadData];
            break;
            
            // 5
        case EKAuthorizationStatusNotDetermined: {
            __weak IMIHLDoctBookingApptVC *weakSelf = self;
            [self.eventStore requestAccessToEntityType:EKEntityTypeReminder
                                            completion:^(BOOL granted, NSError *error) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    weakSelf.isAccessToEventStoreGranted = granted;
                                                    //[weakSelf.tableView reloadData];
                                                });
                                            }];
            break;
        }
    }
}

- (void)addReminderForToDoItem:(NSString *)item {
    // 1
    if (!self.isAccessToEventStoreGranted)
        return;
    
    // 2
    EKReminder *reminder = [EKReminder reminderWithEventStore:self.eventStore];
    reminder.title = item;
    reminder.calendar = self.calendar;
    reminder.priority=1;
    reminder.dueDateComponents = [self dateComponentsForDefaultDueDate];
    
    // 3
    NSError *error = nil;
    BOOL success = [self.eventStore saveReminder:reminder commit:YES error:&error];
    if (!success) {
        // Handle error.
    }
    
    // 4
    NSString *message = (success) ? @"Reminder was successfully added!" : @"Failed to add reminder!";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
    [alertView show];
}

#pragma mark - Helper methods

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshotFromView:(UIView *)inputView {
    
    UIView *snapshot = [inputView snapshotViewAfterScreenUpdates:YES];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

- (NSDateComponents *)dateComponentsForDefaultDueDate {
    /*
     NSDateComponents *oneDayComponents = [[NSDateComponents alloc] init];
     oneDayComponents.day = 1;
     
     NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
     NSDate *tomorrow = [gregorianCalendar dateByAddingComponents:oneDayComponents toDate:[NSDate date] options:0];
     
     NSUInteger unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
     NSDateComponents *tomorrowAt4PM = [gregorianCalendar components:unitFlags fromDate:tomorrow];
     tomorrowAt4PM.hour = 16;
     tomorrowAt4PM.minute = 0;
     tomorrowAt4PM.second = 0;
     */
    
    
    NSDateFormatter*formate = [[NSDateFormatter alloc]init];
    [formate setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *today = [formate dateFromString:self.apptdate_str];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *weekdayComponents =
    [gregorian components:unitFlags fromDate:today];
    weekdayComponents.day=-1;
    
    //NSInteger day = [weekdayComponents day];
    //NSInteger weekday = [weekdayComponents weekday];
    
    return weekdayComponents;
}

- (BOOL)itemHasReminder:(NSString *)item {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title matches %@", item];
    NSArray *filtered = [self.reminders filteredArrayUsingPredicate:predicate];
    return (self.isAccessToEventStoreGranted && [filtered count]);
}


@end
