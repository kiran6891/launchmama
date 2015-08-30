//
//  FIrstOverlayViewController.m
//  AwesomeApp
//
//  Created by Kiran Ruth on 29/08/15.
//  Copyright (c) 2015 Kiran Ruth. All rights reserved.
//

#import "FIrstOverlayViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"


@interface FIrstOverlayViewController ()

@end

@implementation FIrstOverlayViewController

UIImageView *qrImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 20.0f;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Fetching Awesome Stuff";
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *uuid;
    if ([prefs stringForKey:@"uuid"]) {
        uuid = [prefs stringForKey:@"uuid"];
    }else{
        uuid = [[NSUUID UUID] UUIDString];
        [prefs setValue:uuid forKey:@"uuid"];
    }
    [prefs synchronize];
    


    // 1
    NSString *string = [NSString stringWithFormat:@"%@/api/i/1/get_qr_details?api_key=%@&device_id=%@",LM_BASE_URL,LM_API_KEY,uuid];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [hud hide:YES];
        NSDictionary *result = (NSDictionary *)responseObject;
        
        qrImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100,60, 200 ,200 )];
        NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",LM_BASE_URL,[result valueForKey:@"qr_image_url"]];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            qrImage.image = [UIImage imageWithData:data];
        }];
        [self.view addSubview:qrImage];
        
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(40, 300, self.view.frame.size.width-100, 160)];
        label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:22.0f];
        label.text = [result valueForKey:@"offer_description"];
        label.textColor = [UIColor grayColor];
        label.numberOfLines = 0;
        [self.view addSubview:label];
        
        UIImageView *passbook = [[UIImageView alloc] initWithFrame:CGRectMake(20, 470, 300, 100)];
        [passbook setContentMode:UIViewContentModeCenter];
        [passbook setImage:[UIImage imageNamed:@"passbook"]];
        [self.view addSubview:passbook];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];

    }];
    
    [hud show:YES];
    
    // 5
    [operation start];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
