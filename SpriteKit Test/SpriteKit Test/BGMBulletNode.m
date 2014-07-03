//
//  BGMBulletNode.m
//  SpriteKit Test
//
//  Created by 馬 岩 on 14-7-2.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMBulletNode.h"

#import "BGMPhysicsCategories.h"
#import "BGMGeometry.h"

@interface BGMBulletNode ()
@property (assign, nonatomic) CGVector thrust;
@end

@implementation BGMBulletNode

- (instancetype)init
{
    if (self = [super init])
	{
        SKLabelNode *dot = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        dot.fontColor = [SKColor blackColor];
        dot.fontSize = 40;
        dot.text = @".";
        [self addChild:dot];
		SKPhysicsBody *body = [SKPhysicsBody bodyWithCircleOfRadius:1];
        body.dynamic = YES;
        body.categoryBitMask = PlayerMissileCategory;
        body.contactTestBitMask = EnemyCategory;
        body.collisionBitMask = EnemyCategory;
        body.mass = 0.01;
        self.physicsBody = body;
        self.name = [NSString stringWithFormat:@"Bullet %p", self];
    }
    return self;
}

+ (instancetype)bulletFrom:(CGPoint)start toward:(CGPoint)destination
{
    BGMBulletNode *bullet = [[self alloc] init];
    bullet.position = start;
    CGVector movement = BGMVectorBetweenPoints(start, destination);
    CGFloat magnitude = BGMVectorLength(movement);
    if (magnitude == 0.0f) return nil;
    CGVector scaledMovement = BGMVectorMultiply(movement, 1 / magnitude);
    CGFloat thrustMagnitude = 100.0;
    bullet.thrust = BGMVectorMultiply(scaledMovement, thrustMagnitude);
    return bullet;
}

- (void)applyRecurringForce
{
    [self.physicsBody applyForce:self.thrust];
}

@end
