//
//  LeftSlideMenuTableViewController.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 17/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "LeftSlideMenuTableViewController.h"
#import "MFSideMenu.h"
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
#import "IMIHLMyProfile.h"
#import "IMIHLReport.h"
#import "IMIHLRemainder.h"

@interface LeftSlideMenuTableViewController ()
{
    NSArray*menulist_arr;
    NSArray*menupersonallist_arr;
    
    NSArray*menuapointlistimgs_arr;
    NSArray*menuapointlist_arr;
    
    NSArray*menulistimgs_arr;
    NSArray*menupersonallistimgs_arr;
    NSArray*vcidentifiers_arr;
    NSArray*vcidentifierssecone_arr;
    NSArray*vcidentifiersthirdone_arr;
    
    
    
}

@end

@implementation LeftSlideMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.navigationController.navigationBarHidden=YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setTitlesIconsForMenu];
    [self.tableView reloadData];

    self.userNameLble.text = self.patientName;
    self.userEmailLble.text = self.patientEmail;
    [self.userprofileImgView setImage:self.profileImage];
    self.userprofileImgView.layer.cornerRadius = self.userprofileImgView.frame.size.width/2;
    self.userprofileImgView.layer.borderWidth = 2;
    self.userprofileImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userprofileImgView.clipsToBounds = YES;

    /*
    [self.jdAvatarProfileImage setImageWithURL:[NSURL URLWithString:self.patientProfileImage]
                            placeholder:nil
                          progressColor:[UIColor orangeColor]
                    progressBarLineWidh:JDAvatarDefaultProgressBarLineWidth
                            borderWidth:JDAvatarDefaultBorderWidth
                            borderColor:nil
                             completion:^(UIImage * resultImage, NSError * error){
                                 
                                 NSLog(@"image => %@", resultImage);
                                 NSLog(@"error => %@", error);
                                 
                             }];
     */
    
}
-(void)setTitlesIconsForMenu{
    menulist_arr = [[NSArray alloc]initWithObjects:@"Reports",@"Appointments",@"Reminders",@"Profile",@"Invoice",@"Feedback",@"AboutUs",@"LogOut",nil];
    menulistimgs_arr = [[NSArray alloc]initWithObjects:@"baricon",@"appointmentCalender",@"bell",@"user",@"Invoice",@"exclamation",@"aboutus",@"logout",nil];
    
    
    //menuapointlist_arr = [[NSArray alloc]initWithObjects:@"Reports",@"Appointments",@"Reminders",nil];
    //menuapointlistimgs_arr =[[NSArray alloc]initWithObjects:@"baricon",@"appointmentCalender",@"bell",nil];
    
    //menupersonallist_arr = [[NSArray alloc]initWithObjects:@"Profile",@"Invoice",@"Feedback",@"AboutUs", nil];
    
   // menupersonallistimgs_arr  = [[NSArray alloc]initWithObjects:@"user",@"Invoice",@"exclamation",@"aboutus", nil];
    
    
    vcidentifiers_arr = [[NSArray alloc]initWithObjects:@"labreport",@"apntmentsid",@"remainders",@"myprofileid",@"orders",@"feedbackid",@"aboutusid",@"loginpage",nil];
   // vcidentifierssecone_arr = [[NSArray alloc]initWithObjects:@"labreport",@"apntmentsid",@"remainders", nil];
    
    //vcidentifiersthirdone_arr = [[NSArray alloc]initWithObjects:@"myprofileid",@"orders",@"feedbackid",@"aboutusid",nil];
    
    
    
}
-(CGSize)screenSize {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    return screenSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UITableViewDataSource
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section==1) {
    return [NSString stringWithFormat:@"%@",@"Personal Infromation"];
    }
    return nil;
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.view.bounds.size.width<self.view.bounds.size.height){
        return (self.tableView.bounds.size.height/menulist_arr.count);
        
    }
    return (self.tableView.bounds.size.height*0.4);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menulist_arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    NSLog(@"cell1");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    NSLog(@"cell2");
    }
    tableView.rowHeight = UITableViewAutomaticDimension;
        cell.imageView.image = [UIImage imageNamed:[menulistimgs_arr objectAtIndex:indexPath.row]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [menulist_arr objectAtIndex:indexPath.row]];
    
   
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //DemoViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DemoViewController"];
    //demoViewController.title = [NSString stringWithFormat:@"Demo #%d-%d", indexPath.section, indexPath.row];
    /*
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    NSArray *controllers = [NSArray arrayWithObject:demoViewController];
    navigationController.viewControllers = controllers;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
     */
    //bookappointment
    
    NSLog(@"didSelctedCalled");
        [self loadViewControllerFromStoryBoard:[vcidentifiers_arr objectAtIndex:indexPath.row]];
   
    
    
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
    UIImage *myImage = [UIImage imageNamed:@"horizontalbackgrngImg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
    imageView.frame = CGRectMake(0,0,self.tableView.frame.size.width,(self.tableView.frame.size.height)*0.3);
    
        UIImage *profileImg = self.profileImage;
        UIImageView *profileImageView = [[UIImageView alloc] initWithImage:profileImg];
        profileImageView.frame = CGRectMake(5,imageView.frame.size.height-160,(imageView.bounds.size.width)*0.35,(imageView.bounds.size.height)*0.45);
       profileImageView.layer.cornerRadius =profileImageView.bounds.size.width/2;
        profileImageView.clipsToBounds = YES;
        profileImageView.layer.borderWidth = 3;
        profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    UILabel*welcm_lbl = [[UILabel alloc]init];
    [welcm_lbl setText:self.patientName];
    welcm_lbl.textColor = [UIColor whiteColor];
    welcm_lbl.textAlignment = NSTextAlignmentLeft;
    welcm_lbl.frame = CGRectMake(5,imageView.frame.size.height-60,imageView.bounds.size.height,30);
    
    UILabel*patientname_lbl = [[UILabel alloc]init];
    [patientname_lbl setText:self.patientEmail];
    patientname_lbl.font = [UIFont systemFontOfSize:16.0];
    patientname_lbl.textColor = [UIColor whiteColor];
    patientname_lbl.textAlignment = NSTextAlignmentLeft;
    patientname_lbl.frame = CGRectMake(5, imageView.frame.size.height-30,self.tableView.frame.size.width,30);
    
    
    UILabel*patientemail_lbl = [[UILabel alloc]init];
    [patientemail_lbl setText:self.patientEmail];
    patientemail_lbl.font = [UIFont systemFontOfSize:14.0];
    patientemail_lbl.textColor = [UIColor whiteColor];
    patientemail_lbl.textAlignment = NSTextAlignmentLeft;
    patientemail_lbl.frame = CGRectMake(imageView.frame.size.width*0.1, patientname_lbl.frame.origin.y+35,imageView.frame.size.width,30);
   
    [imageView addSubview:profileImageView];
    [imageView addSubview:welcm_lbl];
    [imageView addSubview:patientname_lbl];
    //[imageView addSubview:patientemail_lbl];
    
    return imageView;
    }
    
    else if (section==1){
        UILabel*personal_lbl = [[UILabel alloc]init];
        [personal_lbl setText:@"Appointments"];
        personal_lbl.textColor = [UIColor blackColor];
        personal_lbl.font = [UIFont systemFontOfSize:15.0f];
        personal_lbl.textAlignment = NSTextAlignmentLeft;
        personal_lbl.frame = CGRectMake(0,0,tableView.frame.size.width,30);
        
        CALayer* layer = [personal_lbl layer];
        
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.borderColor = [UIColor lightGrayColor].CGColor;
        bottomBorder.borderWidth = 1;
        bottomBorder.frame = CGRectMake(-1,-1, layer.frame.size.width, 1);
        [bottomBorder setBorderColor:[UIColor lightGrayColor].CGColor];
        [layer addSublayer:bottomBorder];
        
        return personal_lbl;
    }
    
    else{
    
        UILabel*personal_lbl = [[UILabel alloc]init];
        [personal_lbl setText:@"Personal Information"];
        personal_lbl.textColor = [UIColor blackColor];
        personal_lbl.font = [UIFont systemFontOfSize:15.0f];
        personal_lbl.textAlignment = NSTextAlignmentLeft;
        personal_lbl.frame = CGRectMake(0,0,tableView.frame.size.width,30);
        
        CALayer* layer = [personal_lbl layer];
        
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.borderColor = [UIColor lightGrayColor].CGColor;
        bottomBorder.borderWidth = 1;
        bottomBorder.frame = CGRectMake(-1,-1, layer.frame.size.width, 1);
        [bottomBorder setBorderColor:[UIColor lightGrayColor].CGColor];
        [layer addSublayer:bottomBorder];
        
        return personal_lbl;

    
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
    return self.tableView.frame.size.height*0.3;
    }else{
    //return [self screenSize].width*0.1;
        return 0.0f;
    }
    return 0.0f;
}
*/
-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}
#pragma mark - Load ViewControllers

-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    NSLog(@"identifier:%@",identifiername);
    NSLog(@"patientId:%@",self.patientId);
    self.navigationController.navigationBarHidden=NO;
    UINavigationController*navi = self.menuContainerViewController.centerViewController;
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    if ([identifiername isEqualToString:@"myprofileid"]) {
        IMIHLMyProfile * myvc = [storyboard instantiateViewControllerWithIdentifier:@"myprofileid"];
        myvc.patientid_str = self.patientId;
        myvc.patientname_str = self.patientName;
         navi = [navi initWithRootViewController:myvc];
        //[self.navigationController pushViewController:myvc animated:YES];
    }else if ([identifiername isEqualToString:@"labreport"]) {
        IMIHLReport * rvc = [storyboard instantiateViewControllerWithIdentifier:@"labreport"];
        rvc.patientid_str = self.patientId;
        rvc.calledchg_str=@"0";
        rvc.id_str=@"0";
         navi = [navi initWithRootViewController:rvc];
        //[self.navigationController pushViewController:rvc animated:YES];
    }
    
    else if ([identifiername isEqualToString:@"remainders"]) {
        NSLog(@"remianders");
        IMIHLRemainder*reminder = [storyboard instantiateViewControllerWithIdentifier:@"remainders"];
        reminder.patientId = self.patientId;
        
        NSLog(@"centercontainner:%@",self.menuContainerViewController.centerViewController);
        
        
        //
        
        //[self.menuContainerViewController setCenterViewController:nil];
        
        navi = [navi initWithRootViewController:reminder];
        
        
        //[self.navigationController pushViewController:reminder animated:YES];
    }
    else if([identifiername isEqualToString:@"changepassword"]){
        
        IMIHLPassword * pvc = [storyboard instantiateViewControllerWithIdentifier:@"changepassword"];
        pvc.patientid_str = self.patientId;
         navi = [navi initWithRootViewController:pvc];
        //[self.navigationController pushViewController:pvc animated:YES];
        
    }else if([identifiername isEqualToString:@"bookappointment"]){
        
        IMIHLBookAppointment * bvc = [storyboard instantiateViewControllerWithIdentifier:@"bookappointment"];
        bvc.patientid_str = self.patientId;
        bvc.patientname_str = self.patientName;
         navi = [navi initWithRootViewController:bvc];
        //[self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"apntmentsid"]){
        
        IMIHLAppointmentsTableViewController * bvc = [storyboard instantiateViewControllerWithIdentifier:@"apntmentsid"];
        bvc.patientid_str = self.patientId;
        bvc.patientname_str = self.patientName;
         navi = [navi initWithRootViewController:bvc];
       // [self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"searchid"]){
        
        IMIHLSearchVC * bvc = [storyboard instantiateViewControllerWithIdentifier:@"searchid"];
        bvc.patientid_str = self.patientId;
        //bvc.patientname_str = self.patientname_str;
         navi = [navi initWithRootViewController:bvc];
       // [self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"feedbackid"]){
        
        IMIHLFeedback * bvc = [storyboard instantiateViewControllerWithIdentifier:@"feedbackid"];
        bvc.patientid_str = self.patientId;
        //bvc.patientname_str = self.patientname_str;
         navi = [navi initWithRootViewController:bvc];
        //[self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"editprofileid"]){
        
        IMIHLEditProfileVC * bvc = [storyboard instantiateViewControllerWithIdentifier:@"editprofileid"];
        bvc.patientid_str = self.patientId;
        //bvc.patientname_str = self.patientname_str;
        navi = [navi initWithRootViewController:bvc];
        //[self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"myreports"]){
        
        MyReportsVC * bvc = [storyboard instantiateViewControllerWithIdentifier:@"myreports"];
        bvc.patientid_str = self.patientId;
        //bvc.patientname_str = self.patientname_str;
        navi = [navi initWithRootViewController:bvc];
        //[self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"doctorspecialities"]){
        
        IMIHLDrBookAppointment * bvc = [storyboard instantiateViewControllerWithIdentifier:@"doctorspecialities"];
        bvc.patientid_str = self.patientId;
        //bvc.patientname_str = self.patientname_str;
        navi = [navi initWithRootViewController:bvc];
       // [self.navigationController pushViewController:bvc animated:YES];
        
    }else if([identifiername isEqualToString:@"orders"]){
        
        IMIHLOrdersVC * ovc = [storyboard instantiateViewControllerWithIdentifier:@"orders"];
        ovc.patientid_str = self.patientId;
        //bvc.patientname_str = self.patientname_str;
        navi = [navi initWithRootViewController:ovc];
        //[self.navigationController pushViewController:ovc animated:YES];
        
        
    }else if([identifiername isEqualToString:@"drapntmentsid"]){
        
        IMDIHDrPrAppnts * ovc = [storyboard instantiateViewControllerWithIdentifier:@"drapntmentsid"];
        ovc.patientid_str = self.patientId;
        //bvc.patientname_str = self.patientname_str;
        navi = [navi initWithRootViewController:ovc];
        //[self.navigationController pushViewController:ovc animated:YES];
        
        
    }else if([identifiername isEqualToString:@"loginpage"]){
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        navi = [navi initWithRootViewController:vc];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        [self.menuContainerViewController setLeftMenuViewController:nil];
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"testedreports"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userprofiles"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"recentActivities"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userlogin"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"reports"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"remainders"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"previousAppts"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"aboutus"];
        //[[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"reportsdata"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"orderObj"];
        
        //[self.navigationController pushViewController:vc animated:YES];
       // [self presentViewController:vc animated:YES completion:nil];
        
    }else {
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        //[self.navigationController pushViewController:vc animated:YES];
        //[self presentViewController:vc animated:YES completion:nil];
        navi = [navi initWithRootViewController:vc];
    }
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    [self.menuContainerViewController setCenterViewController:navi];
    //[self.menuContainerViewController setCenterViewController:];
   // [self.menuContainerViewController setCenterViewController:]
    //[navigationController pushViewController:vc animated:YES];
    
    //[navigationController pushViewController:vc animated:YES];
}

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
        [self.tableView reloadData];
}



@end
