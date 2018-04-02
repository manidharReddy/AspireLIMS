//
//  IMIHLOrderServiceListVC.m
//  AspireLIMS
//
//  Created by ihub on 27/02/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLOrderServiceListVC.h"
#import "IMIHLRestService.h"
#import "IMIHLOrdersVC.h"
#import "IMIHLPdfViewer.h"
@interface IMIHLOrderServiceListVC ()

@end

@implementation IMIHLOrderServiceListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.serviceListTableView.delegate = self;
    self.serviceListTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Download"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
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

// TableViewDelegateMethods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.services_arr.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.serviceListTableView.bounds.size.height)*0.2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"serviceid";
    
    UITableViewCell *cell = [self.serviceListTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //NSLog(@"cell if");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    NSDictionary*dic =[self.services_arr objectAtIndex:indexPath.row];
    NSString*serviceName = [dic objectForKey:@"serviceName"];
    if ([serviceName isEqual:[NSNull null]]||[serviceName isEqual:nil]||serviceName == NULL || [serviceName isEqualToString:@"null"]) {
        serviceName =@"Not Available";
        
    }
    self.serviceListTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //cell.textLabel.text = serviceName;
    
    UILabel*labl = (UILabel*)[cell viewWithTag:1];
    labl.text = serviceName;
    
    UIButton*btn = (UIButton*)[cell viewWithTag:2];
    btn.tag =  [[dic objectForKey:@"patientserviceid"] intValue];
    [btn addTarget:self action:@selector(downloadTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.layer.cornerRadius = btn.bounds.size.height/2;
    if ([[dic objectForKey:@"downloadable"] boolValue] == true) {
        btn.enabled = true;
    }else{
        btn.enabled = false;
        
        [btn setTitle:@"Pending" forState:UIControlStateNormal];
    }
    
   
    
    
    return cell;
}
#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    
}

-(IBAction)downloadTouched:(id)sender{
    UIButton*dwnbtn = (UIButton*)sender;
    IMIHLRestService*restservice = [IMIHLRestService getSharedInstance];
    self.serviceid =[NSString stringWithFormat:@"%ld" ,(long)dwnbtn.tag];
    if ([restservice reportDownloadInPDF:self.orderid :self.serviceid :@"report"] == 200) {
        NSLog(@"entred in downlod report");
        [self loadViewControllerFromStoryBoard:@"pdfviewer"];
    }
}

-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    if ([identifiername isEqualToString:@"orders"]) {
         IMIHLOrdersVC* vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        //vc.patientid_str = self.patientid_str;
        //vc.patientname_str = self.patientname_str;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([identifiername isEqualToString:@"pdfviewer"]) {
        IMIHLPdfViewer*pdfviewobj = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        NSLog(@"serviceID:%@",self.serviceid);
        pdfviewobj.orderid_str = [NSString stringWithFormat:@"report_%@",[self.orderid stringByAppendingString:self.serviceid]];
        [self.navigationController pushViewController:pdfviewobj animated:YES];
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

@end
