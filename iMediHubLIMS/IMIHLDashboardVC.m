//
//  DashboardVC.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 18/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLDashboardVC.h"
#import "IMIHLDBManager.h"
#import "AppDelegate.h"
#import "IMIHLMyProfile.h"
#import "IMIHLReport.h"
#import "UILabel+Appearance.h"
#import "IMIHLPassword.h"
#import "IMIHLAboutUs.h"
#import "IMIHLBookAppointment.h"
#import "IMIHLAppointmentsTableViewController.h"
#import "IMIHLSearchVC.h"
#import "IMIHLFeedback.h"
#import "IMIHLEditProfileVC.h"
#import "MyReportsVC.h"
#import "IMIHLDrBookAppointment.h"
#import "IMIHLOrdersVC.h"
#import "IMDIHDrPrAppnts.h"

@interface IMIHLDashboardVC ()


@property(nonatomic,retain)NIDropDown *dropDown;
@property(nonatomic,retain)NSMutableArray*dash_icons_arrs;
@property(nonatomic,retain)NSMutableArray*dash_name_arrs;


@end

@implementation IMIHLDashboardVC


- (void)viewWillAppear:(BOOL)animated {
    //NSLog(@"viewwillappear calleddd");
    self.navigationController.navigationBarHidden=YES;
    //[self.navigationController setNavigationBarHidden:YES animated:NO];   //it hides
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    //NSLog(@"dashboard");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self loggedPatient];
    [self setPatientName];
    
    
    [self dashboardSetting];
   // self.navigationController.navigationBarHidden=YES;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    //NSLog(@"year check:%d",[components year]);
    self.copyright_lbl.text = [NSString stringWithFormat:@"copyright© %lu",[components year]];
    
    
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
self.patient_name_lbl.text = [NSString stringWithFormat:@"%@%@%@",daystate_str,@" ",self.patientname_str];
}

-(CGSize)screenSize {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    return screenSize;
}

/*Dashboard Icons and Names*/
-(void)dashboardSetting{
    
    self.dashboard_collection.backgroundColor = [UIColor whiteColor];
   // self.dashboard_collection.layer.borderWidth=2;
   // UICollectionViewFlowLayout *layout = (id) self.dashboard_collection.collectionViewLayout;
    
    //layout.itemSize = CGSizeMake(100, 150);
   //layout.itemSize = CGSizeMake(self.view.frame.size.width*0.25, self.view.frame.size.height*0.2);
   
   //layout.itemSize = CGSizeMake([self screenSize].width*0.25, [self screenSize].height*0.2);
   //collectionView.frame.size.width*0.25, collectionView.frame.size.height*0.18
   // layout.itemSize = CGSizeZero;

    [self.searchReportsClick setImage:[UIImage imageWithIcon:@"fa-search" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:(self.searchReportsClick.frame.size.height*0.6)] forState:UIControlStateNormal];
    //[self.searchBtn setBackgroundImage:[UIImage imageWithIcon:@"fa-ellipsis-v" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
    self.drop_down_btn.hidden=YES;
    [self.drop_down_btn setBackgroundImage:[UIImage imageWithIcon:@"fa-ellipsis-v" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
   self.dash_icons_arrs = [[NSMutableArray alloc]initWithObjects:@"fa-desktop",@"fa-calendar-check-o",@"fa-file-text-o",@"fa-bell-o",@"fa-users",@"fa-user",@"fa-download",@"fa-comment-o",@"fa-sign-out", nil];
    self.dash_name_arrs = [[NSMutableArray alloc]initWithObjects:@"DASHBOARD",@"APPOINTMENT",@"REPORTS",@"REMAINDER",@"ABOUT US",@"PROFILE",@"DOCUMENTS",@"FEEDBACK",@"SIGN OUT", nil];
    [self.dashboard_collection reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UICollectionView delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dash_icons_arrs.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"dashbrdcollect_cell";
    
    //NSLog(@"cellforitem");
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //cell.layer.borderWidth=0.5;
   // cell.frame = CGRectMake(cell.frame.origin.x+10, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
   UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:99];
   // UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];

   /*
    [recipeImageView setImage:[UIImage imageWithIcon:[self.dash_icons_arrs objectAtIndex:indexPath.row] backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:cell.bounds.size.width/2]];
    */
    
    [recipeImageView setImage:[UIImage imageWithIcon:[self.dash_icons_arrs objectAtIndex:indexPath.row] backgroundColor:[UIColor clearColor] iconColor:[UIColor colorWithRed:59.0/255 green:52.0/255 blue:51.0/255 alpha:1.0] fontSize:cell.bounds.size.width/2]];

    //[recipeImageView setImage:[UIImage imageWithIcon:[self.dash_icons_arrs objectAtIndex:indexPath.row] backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:20]];

   // [recipeImageView sizeToFit];
    //NSLog(@"cell width:%f",cell.frame.size.width);
    //recipeImageView = CGSizeMake(100, 100);

   //recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    UILabel*dash_name_lbl = (UILabel*)[cell viewWithTag:100];
    dash_name_lbl.text = [self.dash_name_arrs objectAtIndex:indexPath.row];
    //dash_name_lbl.font = [UIFont systemFontOfSize:cell.frame.size.width/10];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   // return CGSizeMake([self screenSize].width*0.25, [self screenSize].height*0.18);
    //return CGSizeMake(collectionView.frame.size.width*0.25, collectionView.frame.size.height*0.17);
   return CGSizeMake(collectionView.frame.size.width*0.19, collectionView.frame.size.height*0.16);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return collectionView.bounds.size.width/8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return collectionView.bounds.size.height/10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //NSInteger tag = cell.tag;
    //NSLog(@"%d",(int)indexPath.row);
    
    switch (indexPath.row) {
        case 0:
            [self loadViewControllerFromStoryBoard:@"labreport"];
            
            break;
        case 1:
            [self showAppointmentAlertController];
            //[self loadViewControllerFromStoryBoard:@"bookappointment"];
           // [self loadViewControllerFromStoryBoard:@"privacypolicyid"];
            break;
        case 2:
            [self loadViewControllerFromStoryBoard:@"myreports"];
           
            break;
        case 3:
            [self loadViewControllerFromStoryBoard:@"remainders"];
           
            break;
        case 4:
            [self loadViewControllerFromStoryBoard:@"aboutusid"];
            
            break;
        case 5:
           // [self loadViewControllerFromStoryBoard:@"remainders"];
            [self showProfileAlertController];
           
            break;
        case 6:
           // [self loadViewControllerFromStoryBoard:@"settingsid"];
             [self loadViewControllerFromStoryBoard:@"orders"];
           
            break;
        case 7:
            [self loadViewControllerFromStoryBoard:@"feedbackid"];
            
            break;
        case 8:
            //[self loadViewControllerFromStoryBoard:@"myprofileid"];
            [self deletePatientInfo];
            break;
            
        default:
            break;
    }
}

-(void)deletePatientInfo{
    /*
    IMIHLDBManager*dbmanager = [IMIHLDBManager getSharedInstance];
    //NSLog(@"deletePatientInfo");
    if ([dbmanager deletePatientInfoDB]==0) {
        //[dbmanager deleteReportsListDB];
        //NSLog(@"deletePatientInfo if");
        [dbmanager deletePatientLoginDB];
        
        [self loadViewControllerFromStoryBoard:@"loginpage"];
    }
     */

}


# pragma mark - NIDropDown delegate methods
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    //NSLog(@"%@",sender);
    //NSLog(@"tagvalue:%d",(int)sender.tag);
    /*
    IMIHLDBManager*dbmanager = [IMIHLDBManager getSharedInstance];
    if ([dbmanager deletePatientInfoDB]==0) {
        [dbmanager deleteReportsListDB];
    [self loadViewControllerFromStoryBoard:@"loginpage"];

    }else{
        

    }
     */
}

-(void)rel{
    //    [dropDown release];
    self.dropDown = nil;
    
}


//Load ViewControllers from StoreyBoard

-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    self.navigationController.navigationBarHidden=NO;
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    if ([identifiername isEqualToString:@"myprofileid"]) {
        IMIHLMyProfile * myvc = [storyboard instantiateViewControllerWithIdentifier:@"myprofileid"];
        myvc.patientid_str = self.patientid_str;
        myvc.patientname_str = self.patientname_str;
    [self.navigationController pushViewController:myvc animated:YES];
    }else if ([identifiername isEqualToString:@"labreport"]) {
        IMIHLReport * rvc = [storyboard instantiateViewControllerWithIdentifier:@"labreport"];
        rvc.patientid_str = self.patientid_str;
        rvc.calledchg_str=@"0";
         rvc.id_str=@"0";
        [self.navigationController pushViewController:rvc animated:YES];
    }else if([identifiername isEqualToString:@"changepassword"]){
    
        IMIHLPassword * pvc = [storyboard instantiateViewControllerWithIdentifier:@"changepassword"];
        pvc.patientid_str = self.patientid_str;
        [self.navigationController pushViewController:pvc animated:YES];

    }else if([identifiername isEqualToString:@"bookappointment"]){
        
        IMIHLBookAppointment * bvc = [storyboard instantiateViewControllerWithIdentifier:@"bookappointment"];
        bvc.patientid_str = self.patientid_str;
        bvc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"apntmentsid"]){
        
        IMIHLAppointmentsTableViewController * bvc = [storyboard instantiateViewControllerWithIdentifier:@"apntmentsid"];
        bvc.patientid_str = self.patientid_str;
        bvc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"searchid"]){
        
        IMIHLSearchVC * bvc = [storyboard instantiateViewControllerWithIdentifier:@"searchid"];
        bvc.patientid_str = self.patientid_str;
        //bvc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"feedbackid"]){
        
        IMIHLFeedback * bvc = [storyboard instantiateViewControllerWithIdentifier:@"feedbackid"];
        bvc.patientid_str = self.patientid_str;
        //bvc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"editprofileid"]){
        
        IMIHLEditProfileVC * bvc = [storyboard instantiateViewControllerWithIdentifier:@"editprofileid"];
        bvc.patientid_str = self.patientid_str;
        //bvc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"myreports"]){
        
        MyReportsVC * bvc = [storyboard instantiateViewControllerWithIdentifier:@"myreports"];
        bvc.patientid_str = self.patientid_str;
        //bvc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"doctorspecialities"]){
        
        IMIHLDrBookAppointment * bvc = [storyboard instantiateViewControllerWithIdentifier:@"doctorspecialities"];
        bvc.patientid_str = self.patientid_str;
        //bvc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"orders"]){
        
        IMIHLOrdersVC * ovc = [storyboard instantiateViewControllerWithIdentifier:@"orders"];
        ovc.patientid_str = self.patientid_str;
        //bvc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:ovc animated:YES];
        
        
    }else if([identifiername isEqualToString:@"drapntmentsid"]){
        
        IMDIHDrPrAppnts * ovc = [storyboard instantiateViewControllerWithIdentifier:@"drapntmentsid"];
        ovc.patientid_str = self.patientid_str;
        //bvc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:ovc animated:YES];
        
        
    }else if([identifiername isEqualToString:@"loginpage"]){
       UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        //[self.navigationController pushViewController:vc animated:YES];
       [self presentViewController:vc animated:YES completion:nil];
       
    }else {
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    [self.navigationController pushViewController:vc animated:YES];
        //[self presentViewController:vc animated:YES completion:nil];
    }
    
        //[navigationController pushViewController:vc animated:YES];
}


-(void)showProfileAlertController{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"PROFILE"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"View Profile"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [self loadViewControllerFromStoryBoard:@"myprofileid"];
                                /*
                                  //  The user tapped on "Take a photo"
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                  imagePickerController.delegate = self;
                                 */
                                  //[self presentViewController:imagePickerController animated:YES completion:^{}];
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Edit"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {/*
                                  //  The user tapped on "Choose existing"
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                  imagePickerController.delegate = self;
                                */
                                 // [self presentViewController:imagePickerController animated:YES completion:^{}];
                                  //changepassword
                                  [self loadViewControllerFromStoryBoard:@"editprofileid"];
                                  
                              }];

    UIAlertAction* button3 = [UIAlertAction
                              actionWithTitle:@"Change Password"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {/*
                                //  The user tapped on "Choose existing"
                                UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                imagePickerController.delegate = self;
                                */
                                  // [self presentViewController:imagePickerController animated:YES completion:^{}];
                                  //changepassword
                                  [self loadViewControllerFromStoryBoard:@"changepassword"];
                                  
                              }];

    
    [button0 setValue:[UIImage imageWithIcon:@"fa-times" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
    
    [button1 setValue:[UIImage imageWithIcon:@"fa-user" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
    [button2 setValue:[UIImage imageWithIcon:@"fa-pencil-square-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
    [button3 setValue:[UIImage imageWithIcon:@"fa-exchange" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
    
    
    
    //UILabel * appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
    //[appearanceLabel setAppearanceAlignment:NSTextAlignmentLeft];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    [alert addAction:button3];
    
    alert.popoverPresentationController.sourceView = self.dashboard_collection;
    alert.popoverPresentationController.sourceRect = CGRectMake(self.dashboard_collection.bounds.size.width / 1.2, self.dashboard_collection.bounds.size.height / 2.0, 1.0, 1.0);
    
    
    [self presentViewController:alert animated:YES completion:nil];
    

}

-(void)showAppointmentAlertController{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Appointments"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:@"HYDERABAD"
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Lab Booking"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                 [self loadViewControllerFromStoryBoard:@"bookappointment"];
                                //[self loadViewControllerFromStoryBoard:@"doctorspecialities"];
                                  
                                  /*
                                   //  The user tapped on "Take a photo"
                                   UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                   imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                   imagePickerController.delegate = self;
                                   */
                                  //[self presentViewController:imagePickerController animated:YES completion:^{}];
                              }];
    
    
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Lab Appointments"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {/*
                                //  The user tapped on "Choose existing"
                                UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                imagePickerController.delegate = self;
                                */
                                  // [self presentViewController:imagePickerController animated:YES completion:^{}];
                                  //changepassword
                                  [self loadViewControllerFromStoryBoard:@"apntmentsid"];
                                  
                              }];
    
    
    /*
    
    UIAlertAction* buttondoct = [UIAlertAction
                              actionWithTitle:@"Doctor Booking"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  //[self loadViewControllerFromStoryBoard:@"bookappointment"];
                                  [self loadViewControllerFromStoryBoard:@"doctorspecialities"];
                                  
                                 
                              }];
    

    
    UIAlertAction* buttondocapt = [UIAlertAction
                              actionWithTitle:@"Doctor Appointments"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  // [self presentViewController:imagePickerController animated:YES completion:^{}];
                                  //changepassword
                                  [self loadViewControllerFromStoryBoard:@"drapntmentsid"];
                                  
                              }];
    

    */
    
   // [button1 setValue:[UIImage imageNamed:@"baricon"] forKey:@"image"];
    //[button2 setValue:[UIImage imageNamed:@"baricon"] forKey:@"image"];
    [button0 setValue:[UIImage imageWithIcon:@"fa-times" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
    
    [button1 setValue:[UIImage imageWithIcon:@"fa-flask" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
    [button2 setValue:[UIImage imageWithIcon:@"fa-repeat" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
//[buttondoct setValue:[UIImage imageWithIcon:@"fa-user-md" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
  //  [buttondocapt setValue:[UIImage imageWithIcon:@"fa-repeat" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    //[alert addAction:buttondoct];
    //[alert addAction:buttondocapt];
    
    alert.popoverPresentationController.sourceView = self.view;
    alert.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0);

    [self presentViewController:alert animated:YES completion:nil];
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchReportBtnClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"myreports"];
}

- (IBAction)dropDownClick:(id)sender {
    if (dropdwn_arr==nil) {
        dropdwn_arr = [[NSArray alloc] init];
    }else{
        
    }
    dropdwn_arr = [NSArray arrayWithObjects:@"Logout",nil];
    
    if(self.dropDown == nil) {
        CGFloat f = 50;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :dropdwn_arr :nil :@"down"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)searchBtnClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"searchid"];
}


-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_USEC), dispatch_get_main_queue(),
                   ^{
                       @try {
                           
                           
                           [super presentViewController:viewControllerToPresent animated:flag completion:completion];
                       }
                       @catch (NSException *exception) {
                           //NSLog(@"Exception Handle:%@",exception);
                       }
                       @finally {
                           //NSLog(@"Final Block");
                       }
                   });
}




@end
