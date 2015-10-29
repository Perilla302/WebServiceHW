//
//  Web2ViewController.m
//  WebServiceHW
//
//  Created by Hongjin Su on 10/20/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "Web2ViewController.h"

@interface Web2ViewController () <NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview_web;
@property (weak, nonatomic) IBOutlet UIProgressView *progressview_downloadWeb;

@end

@implementation Web2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webService_ToDownloadWeb];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webService_ToDownloadWeb
{
    NSURLSessionConfiguration *sessionConfigation = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session =[NSURLSession sessionWithConfiguration:sessionConfigation delegate:self delegateQueue:nil];
    
    NSURLSessionDownloadTask *downloadTask =[session downloadTaskWithURL:[NSURL URLWithString:_objMyStructure.trackViewUrl]];
    [downloadTask resume];
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData *webData = [NSData dataWithContentsOfURL:location];
    
//    NSURL *url = [NSURL URLWithString:_urlString];
    
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //        self.imageViewSS.image = [UIImage imageWithData:imageData];
        [_webview_web loadData:webData MIMEType:[nil MIMEType] textEncodingName:<#(nonnull NSString *)#> baseURL:<#(nonnull NSURL *)#>];
        _progressview_downloadWeb.hidden = YES;
    });
    
}


/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = (double)totalBytesWritten/(double)totalBytesExpectedToWrite;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_progressview_downloadWeb setProgress:progress];
    });
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
