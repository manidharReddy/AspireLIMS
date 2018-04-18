//
//  IMIHDoctorProfileView.m
//  iMediHubLIMS
//
//  Created by ihub on 12/23/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHDoctorProfileView.h"
#import "IMIHLDoctorsList.h"
#import <QuartzCore/QuartzCore.h>
@interface IMIHDoctorProfileView ()

@end

@implementation IMIHDoctorProfileView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showDoctorProfileView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.backarrowbutton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backarrowbutton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backarrowbutton];
}
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showDoctorProfileView{
    
    self.doctor_name_lbl.text = [self.doctr_arr objectAtIndex:0];
    self.doctor_studies_lbl.text = [self.doctr_arr objectAtIndex:1];
    self.doctor_specilization_lbl.text = [self.doctr_arr objectAtIndex:2];
    
    // create effect
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
    
    // add effect to an effect view
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.doctor_profile_bgimgview.frame;
    
   
     [self.doctor_profile_pic_imgview setImage:[UIImage imageWithData:[[NSData alloc]initWithBase64EncodedString:[self.doctr_arr objectAtIndex:3] options:0]]];
    self.doctor_profile_bgimgview.image = self.doctor_profile_pic_imgview.image;
    
    // add the effect view to the image view
    [self.doctor_profile_bgimgview addSubview:effectView];
}


- (IBAction)backArrowLeftClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"dashboardvc"];
}
// TableViewDelegateMethods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row==0) {
        [cell.textLabel setText:[NSString stringWithFormat:@"%@ yrs experience",[self.doctr_arr objectAtIndex:4]]];
    }else if (indexPath.row==1) {
        [cell.textLabel setText:[NSString stringWithFormat:@"Rs. %@ Consultation fees",[self.doctr_arr objectAtIndex:5]]];
    }else if (indexPath.row==2) {
        [cell.textLabel setText:[NSString stringWithFormat:@"SERVICES:%@",[self.doctr_arr objectAtIndex:6]]];
    }else if (indexPath.row==3) {
        //[cell.textLabel setText:[self.doctr_arr objectAtIndex:7]];
    }
    //[cell.textLabel setText:@"Doctor..."];
    return cell;
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section{
    NSString *headerTitle;
    
    headerTitle = @"Specialities";
    
    return headerTitle;
}
*/

/*
#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"Section:%d Row:%d selected and its data is %@",
          indexPath.section,indexPath.row,cell.textLabel.text);
    self.deptid_str = [NSString stringWithFormat:@"%@",[self.deptidlist_arr objectAtIndex:indexPath.row]];
    self.specialityname_str =cell.textLabel.text;
    [self loadViewControllerFromStoryBoard:@"doctorslist"];
}

*/
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
            IMIHLDoctorsList * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        //vc.patientid_str = self.patientid_str;
        //vc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:vc animated:YES];
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

@end
