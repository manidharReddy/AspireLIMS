//
//  MyReportsVC.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 24/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "MyReportsVC.h"
#import "IMIHLReport.h"
#import "IMIHLRestService.h"
#import "IMIHLDepartment.h"
#import "IMIHLTest.h"
@interface MyReportsVC (){
    BOOL txtfldoneflag,txtfldtwoflag,dropdownflagone,dropdownflagtwo;
    NSArray *arryList;
    DropDownListView * Dropobj;

}

@property(strong,nonatomic) NSString*date_str;

@end

@implementation MyReportsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.calenderView.calendarDelegate=self;
    self.fsCalender.dataSource=self;
    self.fsCalender.delegate=self;
    self.fsCalender.appearance.headerMinimumDissolvedAlpha = 0;
    self.fsCalender.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    [_fsCalender selectDate:[NSDate date]];
    self.navigationController.navigationBarHidden=NO;
   //[self.myreportsbackItem_btn setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
   // [self setData];
   // self.fsCalender.hidden=YES;
   // [self getDepartmentList];
   // self.fsCalender.hidden=YES;
    self.calendarPopView.hidden=YES;
    
    //UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCalendar)];
    //[self.calendarPopView addGestureRecognizer:tapgesture];
    
    [self.leftCalenderBtn setImage:[UIImage imageWithIcon:@"fa-chevron-circle-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
    
    
    [self.rightCalenderBtn setImage:[UIImage imageWithIcon:@"fa-chevron-circle-right" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];

    self.fsCalender.alpha=1.0;
    self.checkAvailableReportsBtn.layer.cornerRadius = self.checkAvailableReportsBtn.bounds.size.height/2;
    self.checkAvailableReportsBtn.clipsToBounds = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.myreportsbackItem_btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.myreportsbackItem_btn setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.myreportsbackItem_btn];
}

- (void)goBack
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)hideCalendar{
    self.calendarPopView.hidden=YES;
}


-(void)getDepartmentList{
    
    IMIHLRestService*restgetdept = [IMIHLRestService getSharedInstance];
    //int statuscode =[restgetdept getDepartments:@"1"];
    [restgetdept getDepartments:@"1" withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            //NSLog(@"status of departments:%@",restgetdept.restresult_dict);
            IMIHLDepartment*deptobj = [[IMIHLDepartment alloc]init];
            deptobj = [deptobj getDepartmentResult:restgetdept.restresult_dict];
            self.deptidlist_arr = deptobj.deptid_arr;
            self.deptnamelist_arr = deptobj.deptname_arr;
        }else if(response==0){
            [self showAlertController:@"No Network Connection"];
        }else{
            //NSLog(@"Error Message:%@",[restgetdept.restresult_dict objectForKey:@"msg"]);
             [self showAlertController:[restgetdept.restresult_dict objectForKey:@"msg"]];
        }
    }];
    
}

-(void)getDepartmentTestList{
    
    IMIHLRestService*restgetdepttests = [IMIHLRestService getSharedInstance];
    //int statuscode =[restgetdepttests getServices:self.deptid_str];
    [restgetdepttests getServices:self.deptid_str withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            
            //NSLog(@"status of departments tests:%@",restgetdepttests.restresult_dict);
            IMIHLTest*testobj = [[IMIHLTest alloc]init];
            testobj = [testobj getDepartmentTestsResult:restgetdepttests.restresult_dict];
            self.testidlist_arr = testobj.testid_arr;
            self.testnamelist_arr = testobj.testname_arr;
        }else if(response==0){
            [self showAlertController:@"No Network Connection"];
        }else{
            //NSLog(@"Error Message:%@",[restgetdepttests.restresult_dict objectForKey:@"msg"]);
            [self showAlertController:[restgetdepttests.restresult_dict objectForKey:@"msg"]];
        }
    }];
    
}



-(void)setData{
arryList=@[@"India",@"Swaziland",@"Africa",@"Australlia",@"Pakistan",@"Srilanka",@"Mexico",@"United Kingdom",@"United States",@"Portugal"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - FSCalender Methods
- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    //_calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    //NSLog(@"did select date %@",[calendar stringFromDate:date format:@"yyyy/MM/dd"]);
   /*
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[calendar stringFromDate:date format:@"yyyy/MM/dd"]];
    }];
    */
    
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[calendar stringFromDate:date format:@"yyyy-MM-dd"]];
    }];
    //NSLog(@"selected dates is %@",selectedDates);
    if (txtfldoneflag==1) {
        self.fromdate_btn.titleLabel.text = [selectedDates objectAtIndex:0];
        self.fromdate_str =[NSString stringWithFormat:@"%@",[selectedDates objectAtIndex:0]];
        
        self.fromdateformate_str=[calendar stringFromDate:date format:@"dd-MM-yyyy"];
    }else if (txtfldtwoflag==1){
    self.todate_btn.titleLabel.text = [selectedDates objectAtIndex:0];
        self.todate_str =[NSString stringWithFormat:@"%@",[selectedDates objectAtIndex:0]];
        self.todateformate_str=[calendar stringFromDate:date format:@"dd-MM-yyyy"];
    }else{
        //NSLog(@"else else calender");
    
    }
    
  //  self.fsCalender.hidden=YES;
    [self hideCalendar];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{
    return [NSDate date];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    //NSLog(@"%s %@", __FUNCTION__, [calendar stringFromDate:calendar.currentPage]);
}

#pragma mark -kDropDown
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:0.0 G:108.0 B:194.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    if (dropdownflagone==1) {
    _selectDeptBtn.titleLabel.text=[self.deptnamelist_arr objectAtIndex:anIndex];
        self.deptid_str = [self.deptidlist_arr objectAtIndex:anIndex];
    }else if (dropdownflagtwo==1) {
    _selectTestBtn.titleLabel.text=[self.testnamelist_arr objectAtIndex:anIndex];
        self.testid_str = [self.testidlist_arr objectAtIndex:anIndex];
    }
    
}
/*
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    ///----------------Get Selected Value[Multiple selection]-----------------//
    if (ArryData.count>0) {
        _lblSelectedCountryNames.text=[ArryData componentsJoinedByString:@"\n"];
        CGSize size=[self GetHeightDyanamic:_lblSelectedCountryNames];
        _lblSelectedCountryNames.frame=CGRectMake(16, 240, 287, size.height);
    }
    else{
        _lblSelectedCountryNames.text=@"";
    }
    
}
*/
- (void)DropDownListViewDidCancel{
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
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





#pragma mark - Load ViewControllers
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier myreports:%@",identifiername);

NSString * storyboardName = @"Main";
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    if ([identifiername isEqualToString:@"labreport"]) {
        
        IMIHLReport * rvc = [storyboard instantiateViewControllerWithIdentifier:@"labreport"];
        rvc.patientid_str = self.patientid_str;
        
        
        
        if (self.tempreportdict==nil) {
            //rvc.id_str = @"0";
            rvc.todate_str=self.todate_str;
            rvc.fromdate_str=self.fromdate_str;
            rvc.datestore_str =[NSString stringWithFormat:@"%@%@to%@%@",self.fromdateformate_str,@" ",@" ",self.todateformate_str];
            
        }else{
          // rvc.id_str = @"1";
            //rvc.calledchg_str=@"1";
            rvc.tempreportdict = self.tempreportdict;
            rvc.datestore_str = self.filterdateshow_str;
        }
         //NSLog(@"ELSE Block calledchg_str:%@",self.calledchg_str);
        rvc.id_str=self.calledchg_str;
        rvc.calledchg_str=self.calledchg_str;
        //NSLog(@"ELSE Block calledchg_str:%@",rvc.calledchg_str);
        //NSLog(@"tempreportdict myrep:%@",self.tempreportdict);
        [self.navigationController pushViewController:rvc animated:YES];
    }else{
UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
//[self presentViewController:vc animated:YES completion:nil];
[self.navigationController pushViewController:vc animated:YES];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)myReportsBackClick:(id)sender {
    //NSLog(@"my back:%@",self.calledchg_str);
    if ([self.calledchg_str isEqualToString:@"1"]) {
    [self loadViewControllerFromStoryBoard:@"labreport"];
    }else{
    [self loadViewControllerFromStoryBoard:@"dashboardvc"];
    }
        
    
}

- (IBAction)previuosDateClick:(id)sender {
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
- (IBAction)fromDateClick:(id)sender {
    
    self.calendarPopView.hidden=NO;
    
    //self.fsCalender.hidden=NO;
    txtfldoneflag=1;
    txtfldtwoflag=0;
    
    
    
}

- (IBAction)toDateClick:(id)sender {
    self.calendarPopView.hidden=NO;
   // self.fsCalender.hidden=NO;
    txtfldoneflag=0;
    txtfldtwoflag=1;
}
- (IBAction)selectDeparmentClick:(id)sender {
    self.testnamelist_arr=nil;
    self.testidlist_arr=nil;
    
    dropdownflagone=1;
    dropdownflagtwo=0;
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Department" withOption:self.deptnamelist_arr xy:CGPointMake(30, self.leftCalenderBtn.frame.origin.y-50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];

}

- (IBAction)selectTestClick:(id)sender {
    
    if (self.deptid_str==nil) {
        //NSLog(@"empty");
        [self showAlertController];
    }else if(self.testidlist_arr==nil && self.deptid_str!=nil){
        //NSLog(@" if djsk testidlist_arr:%@",self.testidlist_arr);
        [self getDepartmentTestList];
        [Dropobj fadeOut];
        dropdownflagone=0;
        dropdownflagtwo=1;
        [self showPopUpWithTitle:@"Select Test" withOption:self.testnamelist_arr xy:CGPointMake(30, self.leftCalenderBtn.frame.origin.y-50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
    }else if(self.testidlist_arr!=nil){
        
        //NSLog(@"testidlist_arr:%@",self.testidlist_arr);
        dropdownflagone=0;
        dropdownflagtwo=1;
        
        [self showPopUpWithTitle:@"Select Test" withOption:self.testnamelist_arr xy:CGPointMake(30, self.leftCalenderBtn.frame.origin.y-50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
        
    }
    
    /*
    if (self.deptid_str==nil) {
        
        [self showAlertController];
    }else{
        
        [self getDepartmentTestList];
    [Dropobj fadeOut];
    dropdownflagone=0;
    dropdownflagtwo=1;
    [self showPopUpWithTitle:@"Select Test" withOption:self.testnamelist_arr xy:CGPointMake(30, self.leftCalenderBtn.frame.origin.y-50) size:CGSizeMake((self.view.frame.size.width-60), (self.view.frame.size.height - self.leftCalenderBtn.frame.origin.y-50)) isMultiple:NO];
    }
     
     */
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

- (IBAction)serachReportsClick:(id)sender {
    if ([self.todate_str isEqualToString:@""]||self.todate_str==nil||[self.fromdate_str isEqualToString:@""]||self.fromdate_str==nil) {
        //NSLog(@"Empty Feilds");
        [self showAlertController:@"FromDate and ToDate in mandatory"];
    }else{
        
        self.calledchg_str=@"1";
        self.tempreportdict=nil;
        [self loadViewControllerFromStoryBoard:@"labreport"];
    }
    
}
-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Message"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
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


- (IBAction)closePopUpClick:(id)sender {
    [self hideCalendar];
}
@end
