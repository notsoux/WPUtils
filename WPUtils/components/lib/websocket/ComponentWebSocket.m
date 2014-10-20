//
//  ComponentWebSocket.m
//  georunning
//
//  Created by William Pompei on 14/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import "ComponentWebSocket.h"

#import <SocketRocket/SRWebSocket.h>

@interface ComponentWebSocket()< SRWebSocketDelegate>{
   SRWebSocket *webSocket;
   void ( ^messageBlock)( id);
   void ( ^openBlock)( void);
   void ( ^failBlock)( NSError *);
   void ( ^closeBlock)(  NSInteger, NSString *, BOOL);
}

@end

@implementation ComponentWebSocket

#pragma mark - setup block

-( id)initForUrl:( NSString *)urlString messageReceived:( void( ^)(id)) __message
            open:( void( ^)( void)) __openBlock
            fail:( void( ^)( NSError *)) __failBlock
           close:( void( ^)( NSInteger, NSString *, BOOL)) __closeBlock{
   self = [super init];
   if( self){
      NSURL *url = [NSURL URLWithString: urlString];
      webSocket = [[SRWebSocket alloc] initWithURL: url];
      webSocket.delegate = self;
      messageBlock = __message;
      openBlock = __openBlock;
      failBlock = __failBlock;
      closeBlock = __closeBlock;
   }
   return self;
}

#pragma mark - websocket management

-( void)open{
   [webSocket open];
}

-( void)close{
   [webSocket close];
}

-( void)sendMessage:( id) data{
   if( webSocket.readyState == SR_CLOSED){
#warning manage WS closed (eg. server went down) mybe using a block
   } else {
      [webSocket send: data];
   }
}

#pragma mark - delegate (internal use)

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
   if( messageBlock){
      messageBlock( message);
   }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
   if( openBlock){
      openBlock( );
   }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
   if( failBlock){
      failBlock( error);
   }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
   if( closeBlock){
      closeBlock( code, reason, wasClean);
   }
}


@end
