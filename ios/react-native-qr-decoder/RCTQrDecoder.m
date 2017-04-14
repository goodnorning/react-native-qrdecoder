

#import "RCTQrDecoder.h"
#import <UIKit/UIKit.h>
#import <React/RCTBridge.h>
#import <React/RCTLog.h>
#import <React/RCTUtils.h>
#import <React/RCTEventDispatcher.h>

@implementation RCTQrDecoder

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(get:(NSString *)path callback:(RCTResponseSenderBlock)callback)
{
    // Change this depending on what you want to retrieve:
    NSString* qrcodeImage = path;
    NSLog(@"qrcodeImage: %@", qrcodeImage);

	UIImage *srcImage = [[UIImage alloc] initWithContentsOfFile:qrcodeImage];
    if (nil==srcImage){
        NSLog(@"PROBLEM! IMAGE NOT LOADED\n");
        callback(@[RCTMakeError(@"IMAGE NOT LOADED!", nil, nil)]);
        return;
    }else
        NSLog(@"OK - IMAGE LOADED\n");
	// [srcImage release];

    NSDictionary *detectorOptions = @{@"CIDetectorAccuracy": @"CIDetectorAccuracyHigh"};
	CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:detectorOptions];
	CIImage *image = [CIImage imageWithCGImage:srcImage.CGImage];
	NSArray *features = [detector featuresInImage:image];
    NSLog(@"Feature size: %lu", (unsigned long)features.count);
    if (0==features.count){
        NSLog(@"PROBLEM! Feature size is zero!\n");
        callback(@[RCTMakeError(@"Feature size is zero!", nil, nil)]);
        return;
    }
    
	CIQRCodeFeature *feature = [features firstObject];

	NSString *result = feature.messageString;
	NSLog(@"result: %@", result);

	if (result)
	{
		/* code */
		callback(@[[NSNull null], result]);
	}else{
    	callback(@[RCTMakeError(@"QR Parse failed!", nil, nil)]);
    	return;
	}
}

@end
