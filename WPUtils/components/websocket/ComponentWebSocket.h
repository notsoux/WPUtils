//
//  ComponentWebSocket.h
//  georunning
//
//  Created by William Pompei on 14/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComponentWebSocket : NSObject

-( id)initForUrl:( NSString *)urlString messageReceived:( void( ^)(id)) __message
            open:( void( ^)( void)) __openBlock
            fail:( void( ^)( NSError *)) __failBlock
           close:( void( ^)( NSInteger, NSString *, BOOL)) __closeBlock;

-( void)open;
-( void)close;

-( void)sendMessage:( id) data;

@end
