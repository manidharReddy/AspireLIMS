//
//  ViewController.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 17/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "ViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "MFSideMenu.h"
#import "IMIHLRestService.h"
#import "ALRecentActivity.h"
#import "IMIHLDBManager.h"
#import "LeftSlideMenuTableViewController.h"
#import "IMIHLBookAppointment.h"
#import "IMIHLSearchVC.h"

@interface ViewController (){
    BOOL logged_user;
    NSArray*recentMenuPopArr;
    NSArray*imagesArr;
    NSArray*recentListArry;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    
     [super viewDidLoad];
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
         LeftSlideMenuTableViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"leftSideMenuViewController"];
    
    //[self.menuContainerViewController setMenuSlideAnimationEnabled:YES];
   

    // Do any additional setup after loading the view, typically from a nib.
    self.testlist_tblview.delegate = self;
    self.testlist_tblview.dataSource = self;
    self.navigationController.navigationBarHidden=YES;
    //self.testlist_tblview.delegate=self;
    //self.testlist_tblview.dataSource=self;
    //[self setIconsForDashboardPage];
    //[self loggedPatient];
    NSLog(@"viewcontroller object");
    self.userLogin = [self getUserInfo];
    self.patientId = self.userLogin.patientid;
    [self setPatientName];
    //[self listOfRecentActivities];
    [self recentActivitiesCall];
    self.bookAppointmentBtn.layer.cornerRadius = self.bookAppointmentBtn.bounds.size.height/2;
    self.bookAppointmentBtn.clipsToBounds = YES;
    leftSideMenuViewController.patientName = [self.userLogin.firstname stringByAppendingString:self.userLogin.lastname];
    leftSideMenuViewController.patientEmail = self.userLogin.emailid;
    leftSideMenuViewController.profileImage = [UIImage imageWithData:self.userLogin.profileimage];
    //leftSideMenuViewController.patientProfileImage = [NSString stringWithFormat:@"%@",self.userLogin.profileimage];
    leftSideMenuViewController.patientId = self.patientId;
    [self.menuContainerViewController setLeftMenuViewController:leftSideMenuViewController];
   
}
-(void)setIconsForDashboardPage{
    [self.leftsidemenu_btn setBackgroundImage:[UIImage imageWithIcon:@"fa-bars" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
    
    [self.dropdown_btn setBackgroundImage:[UIImage imageWithIcon:@"fa-ellipsis-v" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
}

-(void)setPatientName{
    
    //NSLog(@"Patient Name");
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:NSHourCalendarUnit fromDate:date];
    NSString*daystate_str=@"";
    NSInteger hour = [dateComponents hour];
    //NSLog(@"hour:%u",hour);
    if (hour < 12)
    {
        
        // Morning
        daystate_str=@"Good Morning";
    }
    else if (hour >=12 && hour < 16)
    {
        // Afternoon
        daystate_str=@"Good Afternoon";
    }
    else  if (hour >= 16 && hour < 19)
    {
        // Night
        daystate_str=@"Good Evening";
    }else  if (hour >19 && hour <= 21){
        
        daystate_str=@"Good Night";
    }
    self.nameLbl.text = [NSString stringWithFormat:@"%@%@%@",daystate_str,@" ",self.userLogin.firstname];
}


- (void)recentActivitiesCall{
    IMIHLRestService*restService = [IMIHLRestService getSharedInstance];
    [restService recentActivities:self.patientId withCompletionHandler:^(NSInteger response) {
        if (response == 200) {
            self.activityObj = [[IMIHLRecentActivities alloc]init];
            NSLog(@"recentactivities:%@",restService.restresult_dict);
            
            self.activityObj = [self.activityObj setRecentActivitiesList:restService.restresult_dict];
            
            recentListArry =   [NSArray arrayWithArray:self.activityObj.allRecentActivities];
            NSLog(@"items count :%lu",recentListArry.count);
            
            
            
            
            NSData *recentacitivitiesdata = [NSKeyedArchiver archivedDataWithRootObject:self.activityObj];
            
            [[NSUserDefaults standardUserDefaults] setObject:recentacitivitiesdata forKey:@"recentActivities"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.testlist_tblview reloadData];
        }else if(response == 0){
            NSUserDefaults*userdefaults = [NSUserDefaults standardUserDefaults];
            NSData *data = [userdefaults objectForKey:@"recentActivities"];
            self.activityObj  = (IMIHLRecentActivities*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
            //NSLog(@"recentacitvities object:%@",login);
            recentListArry =   [NSArray arrayWithArray:self.activityObj.allRecentActivities];
            [self.testlist_tblview reloadData];
        }
    }];
    
}
-(IMIHLLogin*)getUserInfo{
    NSUserDefaults*userdefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userdefaults objectForKey:@"userprofiles"];
    IMIHLLogin * login = (IMIHLLogin*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"login object:%@",login);
  return login;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftSideMenuItemClicked:(id)sender {
    //[self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
    [self.menuContainerViewController setMenuState:MFSideMenuStateLeftMenuOpen completion:^{}];
    
}
/////////////////////////////Right Side Drop Down//////////////////////////////////////
- (IBAction)rightSideDropDownClicked:(id)sender {
    
    
    if (recentMenuPopArr==nil) {
    recentMenuPopArr = [NSArray arrayWithObjects:@"ALL",@"Reports",@"Appointments", @"Remainders", nil];
        imagesArr = [NSArray arrayWithObjects:@"ic_content_paste_36pt",@"baricon",@"appointmentCalender",@"bell", nil];
        
    }else{
    
    }
    if(dropDown == nil) {
        CGFloat f = self.testlist_tblview.frame.size.height/2;
        
        
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :recentMenuPopArr :imagesArr :@"down"];
        
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
    dropDown.delegate = self;
}

- (IBAction)refreshTouch:(id)sender {
}

- (IBAction)searchTouch:(id)sender {
     [self loadViewControllerFromStoryBoard:@"searchid"];
}

- (IBAction)bookAppointmentTouch:(id)sender {
   [self loadViewControllerFromStoryBoard:@"bookappointment"];
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
   [self rel];
    NSLog(@"%@",sender);
    NSLog(@"tagvalue:%d",(int)sender.tag);
    
    //[self loadViewControllerFromStoryBoard:@"loginpage"];
    
    switch (sender.tag) {
        case 0:
            recentListArry = self.activityObj.allRecentActivities;
            [self.dropdown_btn setTitle:@"ALL" forState:UIControlStateNormal];
            break;
        case 1:
            recentListArry = [self.activityObj.allRecentActivitiesDict objectForKey:@"Patient Orders"];
            [self.dropdown_btn setTitle:@"Reports" forState:UIControlStateNormal];
            break;
        case 2:
            recentListArry = [self.activityObj.allRecentActivitiesDict objectForKey:@"Patient Appointments"];
            [self.dropdown_btn setTitle:@"Appointments" forState:UIControlStateNormal];
            break;
        case 3:
            recentListArry = [self.activityObj.allRecentActivitiesDict objectForKey:@"Patient Appointment Reminders"];
            [self.dropdown_btn setTitle:@"Reminders" forState:UIControlStateNormal];
            break;
    
        default:
            break;
    }
    [self.testlist_tblview reloadData];
    
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
    
}
-(BOOL)shouldAutorotate{
    
    return true;
}
//////////////////////////////////Finished Drop Down/////////////////////////

//////////////////////////////TableView Delegate Methods/////////////////////

// for sections I guess you want 2 sections
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return recentListArry.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return recentListArry.count;
    return 1;
}
-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    NSLog(@"orientation change");
    [self.testlist_tblview reloadData];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.view.frame.size.width<self.view.frame.size.height) {
        return self.testlist_tblview.bounds.size.height/3;
    }
    return self.testlist_tblview.bounds.size.height*0.8;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 // Configure the cell...
     NSLog(@"cell viewcontroller");
     
     UITableViewCell *cell;
     if (indexPath.row>recentListArry.count) {
         
     }else{

          static NSString *CellIdentifier = @"listofactivities";
    
        cell = [self.testlist_tblview dequeueReusableCellWithIdentifier:CellIdentifier];
         if (cell == nil) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
         }
         cell.layer.cornerRadius = 10.0f;
    //self.testlist_tblview.style = UITableViewStyleGrouped;
     
  // self.testlist_tblview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
     //mtable.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
     
     //ALRecentActivity*activity = (ALRecentActivity*)[recentListArry objectAtIndex:indexPath.row];
         ALRecentActivity*activity = (ALRecentActivity*)[recentListArry objectAtIndex:indexPath.section];
      NSLog(@"activityID :%@",activity.activityId);
     if (activity!=nil) {
         
         UIImageView*imgViewLeft =(UIImageView*)[cell viewWithTag:1];
         UILabel*appointmentsLbl=(UILabel*)[cell viewWithTag:2];
          UILabel*appointmentId=(UILabel*)[cell viewWithTag:3];
         if ([activity.activityType isEqualToString:@"Patient Appointments"]) {
             [imgViewLeft setImage:[UIImage imageNamed:@"recentAppointmentActivity"]];
             
             appointmentsLbl.text = @"Appointments";
             appointmentId.text =@"AppointmentId:";
             
         }else if ([activity.activityType isEqualToString:@"Patient Orders"]){
             [imgViewLeft setImage:[UIImage imageNamed:@"report"]];
             appointmentsLbl.text = @"Reports";
             appointmentId.text =@"ReportId:";
             NSLog(@"Reports");
         }else if ([activity.activityType isEqualToString:@"Patient Appointment Reminders"]){
             [imgViewLeft setImage:[UIImage imageNamed:@"remainder"]];
             appointmentsLbl.text = @"Reminders";
             appointmentId.text =@"ReminderId:";
         }
         
        
        
         UILabel*appointmentIdName=(UILabel*)[cell viewWithTag:4];
         appointmentIdName.text = activity.activityId;
         NSLog(@"activityID Appointment:%@",activity.activityId);
         UILabel*appointmentIdSubdate=(UILabel*)[cell viewWithTag:5];
         appointmentIdSubdate.hidden = YES;
         UILabel*appointmentIdDate=(UILabel*)[cell viewWithTag:9];
         appointmentIdDate.text = activity.appointmentDate;
  
     //NSLog(@"patientteststatus_arr value:%@",[patientteststatus_arr objectAtIndex:indexPath.row]);
     
     }
     }
 return cell;
 }
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

///////////////////////////////End Of Table Delegate////////////////////////
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    if ([identifiername isEqualToString:@"loginpage"]) {
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    
    
            //NSLog(@"loginpage");
        [self.menuContainerViewController setLeftMenuViewController:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if([identifiername isEqualToString:@"searchid"]){
        self.navigationController.navigationBar.hidden=NO;
        IMIHLSearchVC * bvc = [storyboard instantiateViewControllerWithIdentifier:@"searchid"];
        bvc.patientid_str = self.patientId;
        //bvc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"bookappointment"]){
        IMIHLBookAppointment * bvc = [storyboard instantiateViewControllerWithIdentifier:@"bookappointment"];
        bvc.patientid_str = self.patientId;
        bvc.patientname_str =[NSString stringWithFormat:@"%@%@%@", self.userLogin.firstname,@" ",self.userLogin.lastname];
        
        
        [self.navigationController pushViewController:bvc animated:YES];
    }
}

@end
