//
//  IMIHLBookAppointment.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 06/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#define MAX_LENGTH 4
#import "IMIHLBookAppointment.h"
#import "IMIHLDepartment.h"
#import "IMIHLTest.h"
#import "IMIHLRestService.h"
#import "IMIHLAppointmentsTableViewController.h"
#import "IMIHLDBManager.h"
#import "IMIHLLocations.h"

@import EventKit;

@interface IMIHLBookAppointment (){
    BOOL dropdownflagone,dropdownflagtwo,dropdownflaglocation;
    //NSArray *deptarryList;
    //DropDownListView * Dropobj;

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

@implementation IMIHLBookAppointment

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.leftBarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    //[self setDepartmentList];
    //[self setTestList];
     //   [self addTextField];
    [self setCalenderView];
    [self getLocationList];
    //[self getDepartmentList];
    self.name_txtfeild.text = self.patientname_str;
    self.name_txtfeild.enabled=NO;
        //UILabel *titleLabel = [UILabel alloc];
    _testName_textField.delegate=self;
    _testName_textField.enabled=YES;
   [self updateAuthorizationStatusToAccessEventStore];
    self.popUpSuccessView.hidden = YES;
   // [self.leftCalenderBtn setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] ];
   // [self.leftCalenderBtn setImage:[UIImage imageWithIcon:@"fa-chevron-circle-left" backgroundColor:[UIColor redColor] iconColor:[UIColor whiteColor] fontSize:20] forState:UIControlStateNormal];
    
   // [self.rightCalenderBtn setImage:[UIImage imageWithIcon:@"fa-chevron-circle-right" backgroundColor:[UIColor redColor] iconColor:[UIColor whiteColor] fontSize:20] forState:UIControlStateNormal];
    
   // [self.bookapntmnt_btn setImage:[UIImage imageWithIcon:@"fa-calendar-check-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
    
    [self.leftCalenderBtn setImage:[UIImage imageWithIcon:@"fa-chevron-circle-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
    
    
    [self.rightCalenderBtn setImage:[UIImage imageWithIcon:@"fa-chevron-circle-right" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];

   // [self.bookapntmnt_btn setImage:[UIImage imageWithIcon:@"fa-calendar" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];

    //NSLog(@"heloooooo");
    self.txtView.layer.borderColor = [UIColor blueColor].CGColor;
    self.txtView.layer.borderWidth = 2;
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    
    formater.dateFormat = @"yyyy-MM-dd";
    
    self.apptdate_str = [formater stringFromDate:[NSDate date]];
    self.txtView.text = @"Please Add tests";
    
    self.yesBtn.layer.cornerRadius = self.yesBtn.bounds.size.height/2;
    self.noBtn.layer.cornerRadius = self.noBtn.bounds.size.height/2;
    self.bookapntmnt_btn.layer.cornerRadius = self.bookapntmnt_btn.bounds.size.height/2;
}

-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.navigationController.navigationBarHidden=NO;
    self.leftBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.leftBarItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.leftBarItem];
}

- (void)goBack
{
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getDepartmentList:(NSString*)locationid{
    
    IMIHLRestService*restgetdept = [IMIHLRestService getSharedInstance];
    //int statuscode =[restgetdept getDepartments:locationid];
    [restgetdept getDepartments:locationid withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            //NSLog(@"status of departments:%@",restgetdept.restresult_dict);
            IMIHLDepartment*deptobj = [[IMIHLDepartment alloc]init];
            deptobj = [deptobj getDepartmentResult:restgetdept.restresult_dict];
            //NSLog(@"deptobj:%@",deptobj.deptid_arr);
            self.deptidlist_arr = deptobj.deptid_arr;
            self.deptnamelist_arr = deptobj.deptname_arr;
            if (self.deptidlist_arr.count!=0) {
                //[self getTestsList:@"" :[self.deptidlist_arr objectAtIndex:0]];
                [self.deptBtn setTitle:[self.deptnamelist_arr objectAtIndex:0] forState:UIControlStateNormal];
                
                self.deptid_str = [self.deptidlist_arr objectAtIndex:0];
            }
        }else if(response==0){
            [self showAlertController:@"No Network Connection"];
        }else{
            //NSLog(@"Error Message:%@",[restgetdept.restresult_dict objectForKey:@"msg"]);
            [self showAlertController:[restgetdept.restresult_dict objectForKey:@"msg"]];
        }
    }];
    
}

-(void)getLocationList{
    IMIHLRestService*restgetdept = [IMIHLRestService getSharedInstance];
    //int statuscode =[restgetdept getLocations:self.patientid_str];
    [restgetdept getLocations:self.patientid_str withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            //NSLog(@"status of departments:%@",restgetdept.restresult_dict);
            IMIHLLocations*locationobj = [[IMIHLLocations alloc]init];
            locationobj = [locationobj getLocationResult:restgetdept.restresult_dict];
            //NSLog(@"locationobjarr:%@",locationobj.locatid_arr);
            self.locationidlist_arr = locationobj.locatid_arr;
            self.locationnamelist_arr = locationobj.locatname_arr;
            if (self.locationidlist_arr.count!=0) {
                [self getDepartmentList:[self.locationidlist_arr objectAtIndex:0]];
                [self.location_dropbtn setTitle:[self.locationnamelist_arr objectAtIndex:0] forState:UIControlStateNormal];
                self.locationid_str = [self.locationidlist_arr objectAtIndex:0];
            }
            
        }else if(response==0){
            [self showAlertController:@"No Network Connection"];
        }else{
            //NSLog(@"Error Message:%@",[restgetdept.restresult_dict objectForKey:@"msg"]);
        }
    }];
}

-(void)getDepartmentTestList{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";
    
    if ([self.testid_str isEqual:[NSNull null]]||self.testid_str==nil) {
        IMIHLRestService*restgetdepttests = [IMIHLRestService getSharedInstance];
        //int statuscode =[restgetdepttests getServices:self.deptid_str];
        [restgetdepttests getServices:self.deptid_str withCompletionHandler:^(NSInteger response) {
            if (response==200) {
                //NSLog(@"status of departments tests:%@",restgetdepttests.restresult_dict);
                IMIHLTest*testobj = [[IMIHLTest alloc]init];
                testobj = [testobj getDepartmentTestsResult:restgetdepttests.restresult_dict];
                
                //NSLog(@"testobj.tmptestdict:%@",testobj.tmptestdict);
                self.tmptest_dict = testobj.tmptestdict;
                self.testidlist_arr = testobj.testid_arr;
                //NSLog(@"testid:%@",testobj.testid_arr);
                self.testnamelist_arr = testobj.testname_arr;
                //NSLog(@"testobj.testname_arr:%@",testobj.testname_arr);
                
            }else if(response==0){
                [self showAlertController:@"No Network Connection"];
            }else{
                self.testnamelist_arr=nil;
                //NSLog(@"Error Message:%@",[restgetdepttests.restresult_dict objectForKey:@"msg"]);
                [self showAlertController:[restgetdepttests.restresult_dict objectForKey:@"msg"]];
            }
        }];
        
    }else{
    
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


-(void)getTestsList:(NSString*)testname :(NSString*)deptid{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";
    if ([self.testid_str isEqual:[NSNull null]]||self.testid_str==nil) {
        IMIHLRestService*restgetdepttests = [IMIHLRestService getSharedInstance];
        //int statuscode =[restgetdepttests getTestName:testname :locid];
       // int statuscode =[restgetdepttests getServices:deptid];
        [restgetdepttests getServices:deptid withCompletionHandler:^(NSInteger response) {
            if (response==200) {
                //NSLog(@"status of location tests tests:%@",restgetdepttests.restresult_dict);
                IMIHLTest*testobj = [[IMIHLTest alloc]init];
                testobj = [testobj getDepartmentTestsResult:restgetdepttests.restresult_dict];
                //NSLog(@"testobjt arr count:%d",testobj.testid_arr.count);
                if (testobj.testid_arr.count!=0) {
                    //NSLog(@"testobj.tmptestdict:%@",testobj.tmptestdict);
                    self.tmptest_dict = testobj.tmptestdict;
                    self.testidlist_arr = testobj.testid_arr;
                    //NSLog(@"testid:%@",testobj.testid_arr);
                    self.testnamelist_arr = testobj.testname_arr;
                    //NSLog(@"testobj.testname_arr:%@",testobj.testname_arr);
                    [self popUpTestList];
                }else{
                    //NSLog(@"PopUpShow");
                    [self showAlertController:@"There is no tests avialable in above location..!"];
                }
            }else if(response==0){
                [self showAlertController:@"No Network Connection"];
            }else{
                self.testnamelist_arr=nil;
                NSLog(@"Error Message:%@",[restgetdepttests.restresult_dict objectForKey:@"msg"]);
                 [self showAlertController:[restgetdepttests.restresult_dict objectForKey:@"msg"]];
            }
        }];
       
    }else{
        
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}


/*-(void) addTextField
{
}
 */

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //if(txtDemo==textField){
    //[scrlView setContentOffset:CGPointMake(0, 50) animated:YES];
    //}
    //NSLog(@"textFieldDidBeginEditing");
    if ([self.testid_str isEqualToString:self.tmptestid_str]) {
        [self popUpTestList];
    }else if(self.deptid_str!=nil){
        [self getTestsList:@"" :self.deptid_str];
    }
   
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //NSLog(@"location id str:%@",self.locationid_str);
    if (textField.text.length!=0) {
        //NSLog(@"textFieldDidEndEditing if");
        if ([self.locationid_str isEqual:[NSNull null]] || self.locationid_str==nil || [self.locationid_str isEqualToString:@"(null)"]) {
            //NSLog(@"textFieldDidEndEditing textfeild");
            [self showAlertController:@"Please select location..!"];
        }else{
        //[self.testName_textField resignFirstResponder];
        //[self getTestsList:textField.text :self.locationid_str];
        }
   }
      //  else{
//        //NSLog(@"textFieldDidEndEditing else");
//    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //NSLog(@"end editing.......");
    
    [self.testName_textField resignFirstResponder];
   
    //[self.usrpasswrd_txt resignFirstResponder];
    //[textField resignFirstResponder];
    return YES;
}

/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //NSLog(@"shouldChangeCharactersInRange");
    // To increase performance I advise you to only make the http request on a string bigger than 3,4 chars, and only invoke it
    if( _testName_textField.text.length + string.length - range.length > 3) // lets say 3 chars mininum
    {
        // call an asynchronous HTTP request
        NSMutableCharacterSet *allowedCharacters = [NSMutableCharacterSet alphanumericCharacterSet];
        [allowedCharacters formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
        [allowedCharacters formUnionWithCharacterSet:[NSCharacterSet symbolCharacterSet]];
        [allowedCharacters addCharactersInString:@":./"];
            
    }
    
    return YES; // this is the default return, means "Yes, you can append that char that you are writing
    // you can limit the field size here by returning NO when a limit is reached
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

/*-(void)setDepartmentList{
    
    self.deptlist_arr = [[NSMutableArray alloc]init];
    [self.deptlist_arr setArray:@[@"India",@"Swaziland",@"Africa",@"Australlia",@"Pakistan",@"Srilanka",@"Mexico",@"United Kingdom",@"United States",@"Portugal"]];
}
  */

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
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    //NSLog(@"%s %@", __FUNCTION__, [calendar stringFromDate:calendar.currentPage]);
}
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar{

    return [NSDate date];
}


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
        self.testnamedb_str = [self.testnamelist_arr objectAtIndex:anIndex];
        self.testBtn.titleLabel.text=[self.testnamelist_arr objectAtIndex:anIndex];
        self.testid_str = [self.testidlist_arr objectAtIndex:anIndex];
        //NSLog(@"testidstrrr:%@",self.testid_str);
        _testName_textField.text =self.testnamedb_str;
    }else if (dropdownflaglocation==1) {
        //self.locationid_str =nil;
        
        self.location_dropbtn.titleLabel.text=[self.locationnamelist_arr objectAtIndex:anIndex];
        self.locationid_str = [self.locationidlist_arr objectAtIndex:anIndex];
        
        if ([self.locationid_str isEqualToString:self.tmplocation_str]) {
            
        }else{
            
            self.txtView.text = @"Please Add tests";
        [self getDepartmentList:self.locationid_str];
        }
        
        //NSLog(@"locationid:%@",self.locationid_str);
    }
    
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    NSLog(@"muiltiple");
    
    /*----------------Get Selected Value[Multiple selection]-----------------*/
    //self.testName_textField.text = @"";
    self.txtView.text = @"Please add tests to book an appointment";
    self.tmptestlist_arr = ArryData;
    self.testid_str = [self makeJsonString];
    //NSLog(@"testid str show:%@",self.testid_str);
    NSMutableString*tmpstring;
    if (ArryData.count>0) {
        //NSLog(@"arrcount");
        tmpstring = [[NSMutableString alloc]init];
        //NSLog(@"joined:%@",[ArryData componentsJoinedByString:@"\n"]);
        
         //_testName_textField.text=[ArryData componentsJoinedByString:@"\n"];
        self.txtView.text =[ArryData componentsJoinedByString:@","];
        /*
        NSLog(@"ArrayData:%@",ArryData);
        NSString*tmpstr;
        for (int i=0; i<ArryData.count; i++) {
            NSLog(@"value:%@",[ArryData objectAtIndex:i]);
           tmpstr = [tmpstring stringByAppendingFormat:@"%d.%@",i+1,[ArryData objectAtIndex:i]];
           
        }
        
        NSLog(@"tmpString:%@",tmpstr);
        self.txtView.text =tmpstr;
         */
    }
    else{
        
    }
    
}

- (void)DropDownListViewDidCancel{
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //NSLog(@"touchview:%@",touch.view);
    if ([touch.view isKindOfClass:[UIView class]]) {
        [_Dropobj fadeOut];
        [self.testName_textField resignFirstResponder];
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

-(void)popUpTestList{
    
    //NSLog(@"TestLocation");
   // //NSLog(@"testlist_arr is %@",_testlist_arr);
    dropdownflagone=0;
    dropdownflagtwo=1;
    dropdownflaglocation=0;
    //[_Dropobj fadeOut];
   // [self showPopUpWithTitle:@"Select Test" withOption:self.testnamelist_arr xy:CGPointMake(30, self.name_txtfeild.frame.origin.y+50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
    [self showPopUpWithTitle:@"Select Test" withOption:self.testnamelist_arr xy:CGPointMake(10, 10) size:CGSizeMake((self.view.frame.size.width-20), (self.view.frame.size.height-20)) isMultiple:YES];

    //self.testnamelist_arr=nil;
    //self.testidlist_arr=nil;
}

- (IBAction)yesTouch:(id)sender {
    self.popUpSuccessView.hidden = YES;
}

- (IBAction)noTouch:(id)sender {
    [self goBack];
}

- (IBAction)selectLocationClick:(id)sender {
    
    if ([self.locationid_str isEqualToString:self.tmplocation_str]) {
        
    }else if([self.deptid_str isEqualToString:self.tempdeptid_str]){
        
        
    
    }else{
        
        self.testnamelist_arr=nil;
        self.testidlist_arr=nil;
    }
    
    dropdownflagone=0;
    dropdownflagtwo=0;
    dropdownflaglocation=1;
    [_Dropobj fadeOut];
    
    
    if (self.view.bounds.size.width<500) {
        [self showPopUpWithTitle:@"Select Location" withOption:self.locationnamelist_arr xy:CGPointMake(self.location_dropbtn.frame.origin.x, self.location_dropbtn.frame.origin.y+50) size:CGSizeMake((self.location_dropbtn.frame.size.width), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
    
    }else{
        [self showPopUpWithTitle:@"Select Location" withOption:self.locationnamelist_arr xy:CGPointMake(self.location_dropbtn.frame.origin.x, self.location_dropbtn.frame.origin.y+50) size:CGSizeMake((self.location_dropbtn.frame.size.width), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
        
    }
    
}

-(void)loaderCall{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Booking....";

}
-(NSString*)makeJsonString{
    
    NSMutableString*jsonstr = [[NSMutableString alloc]init];
    //NSLog(@"self.tmptest_dict:%@",self.tmptest_dict);
    [jsonstr appendString:@"["];
    for (int i=0;i<self.tmptestlist_arr.count;i++) {
        if (self.tmptestlist_arr.count==i+1) {
        [jsonstr appendFormat:@"{\"serviceId\":\"%@\",\"serviceName\":\"%@\"}",[self.tmptest_dict objectForKey:[self.tmptestlist_arr objectAtIndex:i]],[self.tmptestlist_arr objectAtIndex:i]];
        }else{
        [jsonstr appendFormat:@"{\"serviceId\":\"%@\",\"serviceName\":\"%@\"},",[self.tmptest_dict objectForKey:[self.tmptestlist_arr objectAtIndex:i]],[self.tmptestlist_arr objectAtIndex:i]];
        }
        }
    
  //NSString*str=[jsonstr substringWithRange:NSMakeRange(0,[jsonstr length] - 1)];
     [jsonstr appendString:@"]"];
    return jsonstr;
}

- (IBAction)bookAppointmentClick:(id)sender {
    //NSLog(@"book an appointment cliked");
    //NSLog(@"aapdate_str:%@,deptid_str:%@,testid_str:%@",self.apptdate_str,self.deptid_str,self.testid_str);
     //if(self.apptdate_str!=nil&&self.deptid_str!=nil&&self.testid_str!=nil){
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
     }else if(self.testid_str!=nil){
     [self showAlertController:[NSString stringWithFormat:@"Please select test"]];
     }
     */
}


-(void)bookingAppointment{
   
        
        IMIHLRestService*restcreateappt = [IMIHLRestService getSharedInstance];
    
    if (self.locationid_str!=nil  && self.testid_str==nil) {
        //self.locationid_str=@"";
        self.deptid_str=@"";
        self.testid_str=@"";
    }else if ( [self.testid_str isEqual:[NSNull null]] || [self.testid_str isEqualToString:@"(null)"]){
        //self.locationid_str=@"";
        self.deptid_str=@"";
        self.testid_str=@"";
        //self.locationid_str=@"";
    }
   // int statuscode =[restcreateappt createAppointment:self.patientid_str :self.apptdate_str :self.locationid_str :self.deptid_str :self.testid_str];
    
    [restcreateappt createAppointment:self.patientid_str :self.apptdate_str :self.locationid_str :self.deptid_str :self.testid_str withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            //NSLog(@"status of restcreateappt:%@",restcreateappt.restresult_dict);
            //[self showAlertController:@"Successfully sended"];
            
            // NSString*apptid_str =[NSString stringWithFormat:@"%u",[[restcreateappt.restresult_dict objectForKey:@"appontmentId"]integerValue]];
            //NSLog(@"apptid:%@",apptid_str);
            //IMIHLDBManager*dbappnt = [IMIHLDBManager getSharedInstance];
            //[dbappnt deleteAppoinmentsInfoDB];
            //BOOL isSuccess = [dbappnt savePatientAppoinments:apptid_str :self.testnamedb_str :self.apptdate_str :self.deptid_str :@""];
            //if (isSuccess==YES) {
            NSString *string = [self.tmptestlist_arr componentsJoinedByString:@","];
            //NSLog(@"Successfully Inserted in appnt DB");
            //[self showAlertController:[NSString stringWithFormat:@"You have successfully booked an appointment"]];
            
            //[self successFullyBookedStatus:self.apptdate_str time:string];
            //[self showAlert:@"HI"];
            [self myAlertView];
            [self addReminderForToDoItem:[NSString stringWithFormat:@"You have an appointment on %@ for %@",self.apptdate_str,string]];
            
            self.apptdate_str=nil;
            self.locationid_str=nil;
            self.testid_str=nil;
            self.deptid_str=nil;
            
            self.deptBtn.titleLabel.text=@"Select Department";
            self.testBtn.titleLabel.text=@"Select Test";
            self.location_dropbtn.titleLabel.text=@"Select Location";
            //[self loadViewControllerFromStoryBoard:@"dashboardvc"];
            
            //}else{
            //  //NSLog(@"Failed to Insert in appnt DB");
            //}
            
            // [self loadViewControllerFromStoryBoard:@"apntmentsid"];
            
            
        }else if(response==0){
            [self showAlertController:@"No Network Connection"];
        }else{
            //NSLog(@"Error Message:%@",[restcreateappt.restresult_dict objectForKey:@"message"]);
            // [self showAlertController:[restcreateappt.restresult_dict objectForKey:@"message"]];
            [self showAlertController:[NSString stringWithFormat:@"You have failed to book an appointment"]];
        }
    }];
    
        
    
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


-(void)successFullyBookedStatus:(NSString*)date_str time:(NSString*)time{
    UIAlertController*alertContrl = [UIAlertController alertControllerWithTitle:@"" message:@"APPOINTMENT SUCCESS" preferredStyle:UIAlertControllerStyleAlert];
    UIView*backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertContrl.view.frame.size.width,150)];
    backView.backgroundColor = [UIColor blueColor];
    
   
    UIImageView*imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,backView.bounds.origin.y+10 , backView.bounds.size.width,backView.bounds.size.height/2)];
    [imgView setImage:[UIImage imageNamed:@"ic_event_available_white_18pt"]];
    UILabel*lbl = [[UILabel alloc]initWithFrame:CGRectMake(0,imgView.bounds.origin.y+10 , alertContrl.view.bounds.size.width,backView.bounds.size.height/6)];
    lbl.text = @"APPOINTMENT SUCCESS";
    [backView addSubview:imgView];
    [backView addSubview:lbl];
    [alertContrl.view addSubview:backView];
    
    
    UILabel*lbltxt = [[UILabel alloc]initWithFrame:CGRectMake(0,backView.bounds.origin.y+10 , alertContrl.view.bounds.size.width,alertContrl.view.bounds.size.height/6)];
    
    //UILabel*lblDate = [[UILabel alloc]initWithFrame:CGRectMake(0,imgView.bounds.origin.y+10 , alertContrl.view.bounds.size.width,alertContrl.view.bounds.size.height/6)];
   // UILabel*lblTime = [[UILabel alloc]initWithFrame:CGRectMake(0,imgView.bounds.origin.y+10 , alertContrl.view.bounds.size.width,alertContrl.view.bounds.size.height/6)];
    
    
    lbltxt.text = [NSString stringWithFormat:@"Your appointment has been booked on %@ at %@",date_str,time];
    lbltxt.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    UIAlertAction*actionFirst = [UIAlertAction actionWithTitle:@"or" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertContrl.view addSubview:lbltxt];
    [alertContrl addAction:actionFirst];
    [self presentViewController:alertContrl animated:YES completion:nil];

   
     }





-(void)myAlertView{
    self.popUpSuccessView.hidden = NO;
    
    self.dateLbl.text = self.apptdate_str;
    
    
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
NSLog(@"location id dept:%@",self.locationid_str);
    //self.testid_str=nil;
    if (self.locationid_str==nil) {
        NSLog(@"empty");
        [self showAlertController];
    }
   
   /* else if(self.testidlist_arr==nil && self.deptid_str!=nil){
        //NSLog(@"ifksdjsldkjskdjs");
    }
    */
     else if (self.locationid_str!=nil){
        //NSLog(@"selcted:%@",self.locationid_str);
        if ([self.locationid_str isEqualToString:self.tmplocation_str]) {
         
            NSLog(@"if condition same");
        
        }else if([self.deptid_str isEqualToString:self.tempdeptid_str]){
            
            NSLog(@"else condition");
        }else{
            //[self getDepartmentList:self.locationid_str];
            self.tmplocation_str = self.locationid_str;
            self.tempdeptid_str = self.deptid_str;
        }
     
        
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

- (IBAction)selectTestClick:(id)sender {
    if (self.deptid_str==nil) {
        //NSLog(@"empty");
        [self showAlertController];
    }//else if ([self.locationid_str isEqualToString:self.tmplocation_str] && [self.testid_str isEqualToString:self.tmptestid_str]){ //if(self.testidlist_arr==nil && self.deptid_str!=nil){
       else if (self.locationid_str!=nil && self.deptid_str!=nil){
           //NSLog(@"deptid:%@",self.deptid_str);
           //NSLog(@"tempdeptid:%@",self.tempdeptid_str);
           if ([self.deptid_str isEqualToString:self.tempdeptid_str]) {
               
           }else{
          // self.testidlist_arr=nil;
           self.testid_str=nil;
           //NSLog(@" if djsk testidlist_arr:%@",self.testidlist_arr);
           //[self getDepartmentTestList];
           //self.tmptestid_str = self.testid_str;
               self.tempdeptid_str = self.deptid_str;
               
           }
        
           }else{
               
               /*
               [_Dropobj fadeOut];
               dropdownflagone=0;
               dropdownflagtwo=1;
               [self showPopUpWithTitle:@"Select Test" withOption:self.testnamelist_arr xy:CGPointMake(30, self.name_txtfeild.frame.origin.y+50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
                
                */

    }
    
     if (self.testnamelist_arr.count!=0) {
    
    [_Dropobj fadeOut];
    dropdownflagone=0;
    dropdownflagtwo=1;
         if (self.view.frame.size.width<500) {
             [self showPopUpWithTitle:@"Select Test" withOption:self.testnamelist_arr xy:CGPointMake(self.testName_textField.frame.origin.x, self.testName_textField.frame.origin.y+50) size:CGSizeMake(self.testName_textField.frame.size.width, (self.view.frame.size.height - self.bookapntmnt_btn.frame.origin.y-50)) isMultiple:NO];
         
         }else{
             [self showPopUpWithTitle:@"Select Test" withOption:self.testnamelist_arr xy:CGPointMake(self.testName_textField.frame.origin.x, self.testName_textField.frame.origin.y+50) size:CGSizeMake(self.testName_textField.frame.size.width, (self.view.frame.size.height - self.bookapntmnt_btn.frame.origin.y-50)) isMultiple:NO];
         
         }
    
    /*
    else if(self.testidlist_arr!=nil){
        
        //NSLog(@"testidlist_arr:%@",self.testidlist_arr);
        dropdownflagone=0;
        dropdownflagtwo=1;
        
        [self showPopUpWithTitle:@"Select Test" withOption:self.testnamelist_arr xy:CGPointMake(30, self.name_txtfeild.frame.origin.y+50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];

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

- (IBAction)addTestButonTouch:(id)sender {
     if(self.deptid_str!=nil){
        [self getTestsList:@"" :self.deptid_str];
     }else if(self.testid_str!=nil){
         [self popUpTestList];
     }
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
            /*
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Access Denied"
                                                                message:@"This app doesn't have access to your Reminders." delegate:nil
                                                      cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alertView show];
             */
            
            UIAlertController*alertContrl = [UIAlertController alertControllerWithTitle:@"Access Denied" message:@"This app doesn't have access to your Reminders." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction*okAction = [UIAlertAction actionWithTitle:@"Message" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [alertContrl addAction:okAction];
                [self presentViewController:alertContrl animated:YES completion:nil];
            }];
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
            __weak IMIHLBookAppointment *weakSelf = self;
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
    /*
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
    [alertView show];
     */
    UIAlertController*alertContrl = [UIAlertController alertControllerWithTitle:@"Message" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction*okAction = [UIAlertAction actionWithTitle:@"Message" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertContrl addAction:okAction];
    [self presentViewController:alertContrl animated:YES completion:nil];
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
    //weekdayComponents.day=-1;
    
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
