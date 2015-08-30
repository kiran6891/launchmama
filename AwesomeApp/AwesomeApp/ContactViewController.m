//
//  ContactViewController.m
//  AwesomeApp
//
//  Created by Kiran Ruth on 30/08/15.
//  Copyright (c) 2015 Kiran Ruth. All rights reserved.
//

#import "ContactViewController.h"
#import "APPViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bg_imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    [bg_imv setContentMode:UIViewContentModeScaleAspectFill];
    [bg_imv setImage:[UIImage imageNamed:@"trintrin"]];
    [self.view addSubview:bg_imv];
    
    [self performSelector:@selector(popUpAfter)
               withObject:self
               afterDelay:3.0];
    
}

-(void)popUpAfter{
    APPViewController *imo = [[ APPViewController alloc] init];
    self.definesPresentationContext = YES; //self is presenting view controller
    imo.view.alpha  = 1.0f;
    imo.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:imo animated:NO completion:nil];
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
