//
//  ScanViewController.h
//  LaunchMama
//
//  Created by Kiran Ruth on 27/08/15.
//  Copyright (c) 2015 Kiran Ruth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"

@interface ScanViewController : UIViewController<QRCodeReaderDelegate>

- (IBAction)onClickScan:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnScan;

@end
