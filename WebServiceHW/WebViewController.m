//
//  WebViewController.m
//  WebServiceHW
//
//  Created by Hongjin Su on 10/19/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "WebViewController.h"
//#import "DetailViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UIProgressView *myProgressView;
//rui guo add
@property BOOL theBool;
@property NSString *urlString;
@property  NSTimer *myTimer;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //_myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    //[_myWebView setDelegate:self];
    
    

    //NSString *urlString = [NSString stringWithFormat:@"%@", _objMyStructure.trackViewUrl];
    _urlString = @"http://www.google.com/";//_objMyStructure.trackViewUrl;
    
    //rui guo modified
    NSURL *url = [NSURL URLWithString:_urlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    
    [_myWebView loadRequest:urlRequest];
//    //[self.view addSubview:_myProgressView];
//    //[self.view addSubview:_myWebView];
//    // Do any additional setup after loading the view.
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    [webView setDelegate:self];
//    
//    NSString *urlAddress = @"http://www.google.com/";
//    NSURL *url = [NSURL URLWithString:urlAddress];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:requestObj];
//    
//    [self.view addSubview:webView];
    //[self webService_downloadURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//rui guo add
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"load start");
    //rui guo add
    _myProgressView.progress = 0;
    _theBool = false;
    //0.01667 is roughly 1/60, so it will update at 60 FPS
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01667 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_myTimer forMode:NSDefaultRunLoopMode];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    _theBool = true;
    NSLog(@"the web finished");
}
-(void)timerCallback {
    if (_theBool) {
        if (_myProgressView.progress >= 1) {
            _myProgressView.hidden = true;
            [_myTimer invalidate];
        }
        else {
            _myProgressView.progress += 0.1;
        }
    }
    else {
        _myProgressView.progress += 0.05;
        NSLog(@"%f",_myProgressView.progress);
        _myProgressView.progress += 0.05;
        if (_myProgressView.progress >= 0.95) {
            _myProgressView.progress = 0.95;
        }
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
