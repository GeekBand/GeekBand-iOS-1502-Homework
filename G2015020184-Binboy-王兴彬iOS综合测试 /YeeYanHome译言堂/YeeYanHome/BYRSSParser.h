//
//  BYRSSParser.h
//  YeeYanHome
//
//  Created by binglogo on 15/10/10.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYRSSParser : NSObject

- (void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void (^)(NSArray *dataArr))completionHandler;
@end
