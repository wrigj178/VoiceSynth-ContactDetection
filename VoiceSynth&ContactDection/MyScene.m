//
//  MyScene.m
//  VoiceSynth&ContactDection
//
//  Created by Jasmine Wright on 3/4/14.
//  Copyright (c) 2014 Jasmine Wright. All rights reserved.
//

#import "MyScene.h"
@import AVFoundation;

//global variables: CATEGORY BITMASKS VARIABLES THAT DONT CHANGE ARE IN ALL CAPS this is c-language
static const uint32_t RED_CATEGORY = 0x1<<0; //in one bit we are saving this category
static const uint32_t GREEN_CATEGORY = 0x1<<1;
static const uint32_t BLUE_CATEGORY = 0x1<<2;
static const uint32_t SCREENEDGE_CATEGORY = 0x1<<3;//<< is an oporator: gives the # equivialent in binary

@interface MyScene ()<SKPhysicsContactDelegate>
@property SKSpriteNode* redSquare;
@property SKSpriteNode* blueSquare;
@property SKSpriteNode* greenSquare;


@end

@implementation MyScene

-(void) didBeginContact:(SKPhysicsContact *)contact{
    NSLog(@"Entered didBeginContact");
//    uint32_t collision = (contact.bodyA.categoryBitMask |
//                          contact.bodyB.categoryBitMask);
//    if (collision ==(RED_CATEGORY| BLUE_CATEGORY)) {
//        [self speakThisString:@"Red and blue touched"];
    
    
    
//    if contact.bodyA.categoryBitMask ==RED_CATEGORY) {
//        NSLog(@"red hit something");
//        [self speakThisSting:@"r"];
//    }
//    if contact.bodyB.categoryBitMask ==RED_CATEGORY) {
    
    if ((contact.bodyA.categoryBitMask == RED_CATEGORY) ||
        (contact.bodyB.categoryBitMask == RED_CATEGORY) ){
        NSLog(@"red hit something");
//        [self speakThisString:@"r"];
    }
    
    if ((contact.bodyA.categoryBitMask == GREEN_CATEGORY) &&
            (contact.bodyB.categoryBitMask == RED_CATEGORY) ){
            NSLog(@"Green touched Red.");
//            [self speakThisString:@"r"];
            [_greenSquare.physicsBody applyImpulse:CGVectorMake(-1, 20)];
        }
    
    if ((contact.bodyA.categoryBitMask == RED_CATEGORY) &&
                (contact.bodyB.categoryBitMask == GREEN_CATEGORY) ){
                NSLog(@"Green touched Red.");
        }
            
    if ((contact.bodyA.categoryBitMask == GREEN_CATEGORY) &&
        (contact.bodyB.categoryBitMask == BLUE_CATEGORY) ){
        NSString(@"Green touched blue");
        [contact.bodyA.node. physicsBody applyImpulse:-1,20)];
        
    }
            

    
}



-(void) screenSettings{
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    [self.physicsBody setRestitution:1.0];

}

-(void)speakThisString: (NSString*) myLocalString{
    AVSpeechSynthesizer* mySyn = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance* myUtterance= [[AVSpeechUtterance alloc]initWithString:myLocalString];
    [mySyn speakUtterance:myUtterance];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self;
        
//        [self speakThisString:@"I just started"];
        [self screenSettings];
        [self spawnRedSquare];
        [self spawnBlueSquare];
        [self spawnGreenSquare];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    [self speakThisString: @"I touched the screen, so what's next?"];
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    [_redSquare setPosition:touchLocation];
   
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void) spawnGreenSquare{
    
    for (int i = 0; i<50; i++) {
        
    [self speakThisString:@"green"];
    _greenSquare =[SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(18, 18)];
    _greenSquare.position = CGPointMake(100, 400);
    _greenSquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_greenSquare.size];
    [_greenSquare.physicsBody setCategoryBitMask:GREEN_CATEGORY];
    [self addChild:_greenSquare];
                                
                                }
}

-(void)spawnRedSquare{
    [self speakThisString:@"red"];
    _redSquare =[SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(50, 50)];
    _redSquare.position = CGPointMake(100, 100);
    _redSquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_redSquare.size];
    [_redSquare.physicsBody setCategoryBitMask:RED_CATEGORY];
                              [self addChild:_redSquare];
}

-(void)spawnBlueSquare{
    [self speakThisString:@"blue"];
    _blueSquare =[SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(50, 50)];
    _blueSquare.position = CGPointMake(100, 200);
    _blueSquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_blueSquare.size];
    [_blueSquare.physicsBody setCategoryBitMask:BLUE_CATEGORY];
                              [self addChild:_blueSquare];
    
}
                               
@end
