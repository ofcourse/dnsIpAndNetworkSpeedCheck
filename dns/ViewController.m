//
//  ViewController.m
//  dns
//
//  Created by macbook on 2018/11/2.
//  Copyright © 2018年 HSG. All rights reserved.
//

#import "ViewController.h"
#import "DNSResolver.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dnsipAdressLabel;
@property (weak, nonatomic) IBOutlet UITextField *websiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteIpAddressLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)getDnsIpAddress:(id)sender {
    DNSResolver *dns = [[DNSResolver alloc]init];
    self.dnsipAdressLabel.text = [dns getDNSAddressesCSV];
}
- (IBAction)getWebsiteIpAddress:(id)sender {
     DNSResolver *dns = [[DNSResolver alloc]init];
    self.websiteIpAddressLabel.text = [dns getIPWithHostName:self.websiteLabel.text];
}
//IOS网速测试
//https://www.jianshu.com/p/882f9c3fb610  demo github地址  https://github.com/likaiwork/MeasurNetTools

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
