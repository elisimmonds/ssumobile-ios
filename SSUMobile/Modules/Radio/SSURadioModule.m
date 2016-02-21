//
//  SSURadioModule.m
//  SSUMobile
//
//  Created by Eric Amorde on 9/8/15.
//  Copyright (c) 2015 Sonoma State University Department of Computer Science. All rights reserved.
//

#import "SSURadioModule.h"
#import "SSURadioConstants.h"
#import "SSUConfiguration.h"

@implementation SSURadioModule

+ (instancetype) sharedInstance {
    static SSURadioModule * instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - SSUModule

- (NSString *) title {
    return NSLocalizedString(@"Radio",
                             @"The campus online radio status - KSUN Radio");
}

- (UIView *) viewForHomeScreen {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radio_icon"]];
}

- (UIImage *) imageForHomeScreen {
    return [UIImage imageNamed:@"radio_icon"];
}

- (UIViewController *) initialViewController {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Radio_iPhone"
                                                          bundle:[NSBundle bundleForClass:[self class]]];
    return [storyboard instantiateInitialViewController];
}

- (BOOL) shouldNavigateToModule {
    if (![[SSUConfiguration sharedInstance] boolForKey:SSURadioStreamEnabledKey]) {
        /**
         KSUN radio has switched their streaming service to one which does not support
         mobile play. Unfortunately there is nothing we can do about this.
         So we will inform the user of this and go back
         */
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"KSUN Currently Unavailable on Mobile"
                                                         message:@"KSUN Radio has switched to a streaming service which does not support mobile play, as it requires Adobe Flash. SSUMobile has no control over this. If you are interested in getting this functionality back, please contact KSUN Radio with your concerns."
                                                        delegate:nil
                                               cancelButtonTitle:@"Done"
                                               otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (BOOL) showModuleInNavigationBar {
    return NO;
}

@end
