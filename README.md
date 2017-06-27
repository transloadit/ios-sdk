#Important#

The Transloadit iOS SDK works with iOS 7 and Xcode 5 with ARC enabled or with any newer version.


#Installation#

In your podfile add

```pod 'TransloaditAPI'```

#Purpose#

This is the official iOS SDK for the transloadit.com API.

It allows you to easily use Transloadit services in your iPhone or iPad applications.

#Directory structure#

- "TransloaditLib" - Contains the SDK source (Cocoa Touch Static Library)
- "TransloaditLibTest" - Contains unit tests (XCTest project)
- "bin" - compiled archive and includes

#Examples#

The SDK is easy to configure, use and extend. Please see the details below.

##Sample application##

The sample application below is part of a simple iOS application.

###1. Upload a file, use pre-created template with all required settings###

```objective-c
//
//  AppDelegate.m
//  TransloaditArchiveTest
//
//  Created by Szabó Tamás on 2014.01.31..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "AppDelegate.h"
#import "Transloadit.h"
#import "Step.h"
#import "AssemblyBuilder.h"
#import "TransloaditResponse.h"
#import "TransloaditLogger.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
	
	
	
	//Create Transloadit instance
    NSObject<ITransloadit>* transloadit = [[Transloadit alloc] init:@"YOUR-API-KEY"];
	
	//Create assembly builder to build up the assembly
	NSObject<IAssemblyBuilder>* assembly = [[AssemblyBuilder alloc] init];
     
	//Set template ID
	[assembly setTemplateID:@"YOUR-TEMPLATE-ID"];
	
	NSString* path=[NSString stringWithFormat:@"%@/%@",[[NSBundle bundleForClass:[self class]] resourcePath],@"TEST_IMAGE_FILE"];
    
	NSData* img = [NSData dataWithContentsOfFile:path];

    // Alternately here is how to load the data from a UIImage
    // UIImage *someImage;
    // ...initialize someImage with a valid UIImage
    // NSData *img = UIImageJPEGRepresentation(someImage, 0.85);
    
	NSError* error;
    
	//Add a file to be uploaded with autogenerated key
	[assembly addFileWithName:@"myphoto.jpg" file:img withError:error];

    if(error!=nil)
	{
		TRANSLOADIT_LOG_ERROR(self.class,error);
		
		return YES;
	}
	
	//Invoke assembly, and wait for the result
    TransloaditResponse* response =[transloadit invokeAssembly:assembly withError:error];
    
	if(error!=nil)
	{
		TRANSLOADIT_LOG_ERROR_WITH_MESSAGE(self.class,@"Error has occured while completing assembly");
		
		return YES;
	}
	
	if([response isSuccess])
	{
        NSDictionary *data = [response getData];

        // if you have a filter robot called files like this: https://transloadit.com/demos/file-filter/decline-video-bigger-than-20mb-or-longer-than-5min
        // then you can get a url to the original file like this (Note that results.files is an array)
        // NSString *originalFileURL = data[@"results"][@"files"][0][@"url"];

        // if you have a robot named thumbnanils like this: https://transloadit.com/demos/misc/multiple-encoding-steps-for-the-same-file
        // then you can get the first thumbnail like this
        // NSString *thumbnailUrl = data[@"results"][@"thumbnails"][0][@"url"];

		TRANSLOADIT_LOG_INFO(self.class,@"Assembly %@ result",[data objectForKey:@"assembly_id"]);
	}else
	{
		TRANSLOADIT_LOG_ERROR_WITH_MESSAGE(self.class,@"Error has occured while completing assembly");
	}
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

```

###2. Upload a file, with custom assembly with all required and optional settings###

```objective-c
//
//  AppDelegate.m
//  TransloaditArchiveTest
//
//  Created by Szabó Tamás on 2014.01.31..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "AppDelegate.h"
#import "Transloadit.h"
#import "Step.h"
#import "AssemblyBuilder.h"
#import "TransloaditResponse.h"
#import "TransloaditLogger.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
	
	
	
	//Create Transloadit instance
    NSObject<ITransloadit>* transloadit = [[Transloadit alloc] init:@"YOUR-API-KEY"];
	
	//Create assembly builder to build up the assembly
	NSObject<IAssemblyBuilder>* assembly = [[AssemblyBuilder alloc] init];
     
	//Set template ID
	[assembly setTemplateID:@"YOUR-TEMPLATE-ID"];
	
	NSString* path=[NSString stringWithFormat:@"%@/%@",[[NSBundle bundleForClass:[self class]] resourcePath],@"TEST_IMAGE_FILE"];
    
	NSData* img = [NSData dataWithContentsOfFile:path];

    // Alternately here is how to load the data from a UIImage
    // UIImage *someImage;
    // ...initialize someImage with a valid UIImage
    // NSData *img = UIImageJPEGRepresentation(someImage, 0.85);

	NSError* error;
    
	//Add a file to be uploaded with autogenerated key
	[assembly addFileWithName:@"myphoto.jpg" file:img withError:error];

    IF(error!=nil)
	{
		TRANSLOADIT_LOG_ERROR(self.class,error);
		
		return YES;
	}
	
	//Add a file to be uploaded with custom key
	[assembly addFileWithName:@"custom_file" file:img withError:error];

    if(error!=nil)
	{
		TRANSLOADIT_LOG_ERROR(self.class,error);
		
		return YES;
	}
	
	//Define the step, you can define more in the same assembly
    NSObject<IStep>* step=[[Step alloc] init];
    [step setOptionKey:@"robot" object:@"/image/resize"];
    [step setOptionKey:@"width" object:@(75)];
    [step setOptionKey:@"height" object:@(75)];
    [step setOptionKey:@"resize_strategy" object:@"pad"];
    [step setOptionKey:@"background" object:@"#000000"];

    //Add the step to the assembly
	[assembly addStepName:@"thumb" step:step];
	
	//Set notification URL
	[assembly setNotifyURL:@"http://your-service.net/ready"];
	
	//Set the expiration date time of the request for the assembly
	//Assembly will be expired in 120 minutes from now
	NSDate* time=[[NSDate alloc] init];
    [assembly setAuthExpires:[time dateByAddingTimeInterval:120*60]];
	

	//Invoke assembly, and wait for the result
    TransloaditResponse* response =[transloadit invokeAssembly:assembly withError:error];
    
	if(error!=nil)
	{
		TRANSLOADIT_LOG_ERROR_WITH_MESSAGE(self.class,@"Error has occured while completing assembly");
		
		return YES;
	}
	
	if([response isSuccess])
	{
        NSDictionary *data = [response getData];

        // if you have a filter robot called "files" like this: https://transloadit.com/demos/file-filter/decline-video-bigger-than-20mb-or-longer-than-5min
        // then you can get a url to the original file like this (Note that results.files is an array)
        // NSString *originalFileURL = data[@"results"][@"files"][0][@"url"];

        // if you have a robot named "thumbnanils" like this: https://transloadit.com/demos/misc/multiple-encoding-steps-for-the-same-file
        // the you can get the first thumbnail like this
        // NSString *thumbnailUrl = data[@"results"][@"thumbnails"][0][@"url"];

        TRANSLOADIT_LOG_INFO(self.class,@"Assembly %@ result",[data objectForKey:@"assembly_id"]);
	}else
	{
		TRANSLOADIT_LOG_ERROR_WITH_MESSAGE(self.class,@"Error has occured while completing assembly");
	}
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
```

#Transloadit iOS SDK#

You need to download the necessary static library and header files and integrate it to your application. Also you can pull the source code and compile it with your application.

##1. Dependencies##

The Transloadit iOS SDK is not using any external library. 
The SDK works only with Automatic Reference Counting enabled.

##2. Use of the SDK##

If you would like to use the iOS SDK for Transloadit in your application, you need to add it as a static library, or you can use the source directly (easier).

To use the SDK source directly, copy the TransloaditLib directory into your project in XCode.

Transloadit services work with assemblies. An assembly must contain each piece of information which will be used for authentication and processing. Each assembly must contain authentication information and steps or template ID. You can set custom, and optional values like custom fields and files too.

> **Note:** template ID is the ID of a Transloadit template that can be created in your Transloadit account.

###2.1. Use of `Transloadit` class###

With that class you are able to create a Transloadit instance, which will process all the assemblies sent by your application.

`NSObject<ITransloadit>* transloadit = [[Transloadit alloc] init:@"YOUR-API-KEY"];`

> **Note:** You can use Transloadit instances as singleton instances.

###2.2. Build an assembly###

To build up an assembly you need to use `AssemblyBuilder`.

`NSObject<IAssemblyBuilder>* builder = [[AssemblyBuilder alloc] init];`

As described above, to define steps for your assembly you can use `Step` class. Each step must have option(s), which can be set with the `-(void)setOptionKey:(NSString*)key object:(NSObject*)value;` method. That step will be proceeded on your uploaded, or predefined resources.

```objective-c
// Step below will resize the uploaded image to 75x75 size
// with the pad resize strategy and with a black background color

NSObject<IStep>* step=[[Step alloc] init];
[step setOptionKey:@"robot" object:@"/image/resize"];
[step setOptionKey:@"width" object:@(75)];
[step setOptionKey:@"height" object:@(75)];
[step setOptionKey:@"resize_strategy" object:@"pad"];
[step setOptionKey:@"background" object:@"#000000"];
```

To add that step to your assembly you need to call the `-(void) addStepName:(NSString*)name step:(NSObject<IStep>*)step;` method, where the `name` parameter is the key of the step. You can refer to that in further steps in the same assembly, even if you add more.

`[builder addStepName:@"resize" step:step];`

####2.2.1. Add custom field to the assembly####

Custom fields can be set for each assembly as a parameter of a pre-created template. You can set custom fields with `-(void)setFieldKey:(NSString*)key value:(NSString*)value withError:(NSError*)error;` method, where the `key` parameter is the unique key of the field and `value` parameter is the value of the field.

If a valid key is not defined in the custom field collection, then it will be created, also the related value will be set. If a valid key is already defined then it will be overriden with the passed value.

There are some field keys which are used by the SDK. You are not able to use these keys as custom field keys such as "notify_url", "params", "signature", "template_id". If you try to use one of those keys, then an `NSError` will be thrown.

`NSError` will be thrown, if you try to use a custom field key, which is already defined as a key of a file (read about files in the next section below).

`[builder setFieldKey:@"field_key" value:@"field_value" withError:error]`

####2.2.2. Adding a file to an assembly####

You can call `-(void)addFile:(NSData*) file withError:(NSError*)error;` or `-(void)addFileWithName:(NSString*)key file:(NSData*)file withError:(NSError*) error;` method, where the `key` parameter is the unique key of the file and the `file` parameter is the NSData of the file, on the created `builder` object to add a file to your assembly.

If you call the method with only the `file` parameter, then the key of the file will be an autogenerated key. If you call the method with both parameters, then the file will be added with the specified key. If the key is already defined as a custom field key or a file key, then an autogenerated key will be set for the file.

`[builder addFile:img withError:error];` or `[assembly addFileWithName:@"custom_file" file:img withError:error];`

####2.2.3. Setting authentication information####

You can set authentication information as per the examples below.

The Transloadit constructor sets the API key.

The following methods can be called on the `builder` object:

- `-(void)setAuthExpires:(NSDate*)dateTime;` - sets the request expiration date (default 120 minutes)
- `-(void)setAuthMaxSize:(int)maxSize;` - sets the max size (in bytes) of the requests; Please refer to the Transloadit docs here: https://transloadit.com/docs/api-docs#authentication-implementations

```objective-c
NSDate* time=[[NSDate alloc] init];
[builder setAuthExpires:[time dateByAddingTimeInterval:120*60]];//Request will be expired after the current date time + 120 minutes
[builder setAuthMaxSize:1024];
```

> **Note:** These methods are optional

####2.2.4. Set notify URL####

You can define a notify URL for your assembly by calling `-(void)setNotifyURL:(NSString*)notifyURL;` on the `builder` object, which will be requested after the assembly is done on Transloadit server.

`[builder setNotifyURL:@"http://your-service.net/ready"];`

If your assembly is done, then a POST request will be sent to the specified notify URL. That request will contain information about the status of the created assembly and it will also contain all information about the result files.
If Transloadit has sent `assembly_url` as a GET parameter, then that URL will be called by a TransloaditRequest.

> **For example:** You have a mobile application, which invokes assemblies via that iOS SDK, and you have a REST API service written in PHP, which can handle the request which will be sent after the assembly is done. What you need to do is to integrate the PHP Transloadit SDK to your PHP REST API service and call `Transloadit::response()` method, then you will be able to use the result of the assembly in your service (like creating database records for example).

####2.2.5. Set template ID####

You can define a template ID which will be used to process your assembly on the Transloadit servers. You can use `-(void)setTemplateID:(NSString*)templateID;` for that, where the `templateID` parameter is the ID of the precreated template.

`[builder setTemplateID:@"ID-OF-PRECEREATED-TEMPLATE"];`

####2.2.6. Creating an assembly####

Once your assembly is built up you can send it to the Transloadit servers with the `-(TransloaditResponse*)invokeAssembly:(NSObject<IAssemblyBuilder>*)assembly withError:(NSError*)error;` method, where the `builder` parameter is the built up instance of `AssemblyBuilder` class, that can be called on the `transloadit` object. The result of the assembly will be represented in an `ITransloaditResponse` instance.

`TransloaditResponse* response =[transloadit invokeAssembly:builder withError:error];`

Once the request is done and the `response` object was created, you are able to examine its properties:

- `[response getData]` - returns the response as a dictionary (`NSDictionary`)
- `[response getResponseString]` - returns the response string
- `[response isSuccess]` - returns the success of the request

> **Note:** `[response getData]` main Dictionary can store sub Dictionaries as the value of the main Dictionary

####2.2.7. Deleting an assembly####

Transloadit iOS SDK gives you the possibility to delete an assembly on the server. You can call the `-(TransloaditResponse*)deleteAssembly:(NSString*)assemblyID;` method, where `assemblyID` parameter is the ID of an exisiting assembly, on the created `transloadit` object. That call can be useful when you would like to cancel an assembly.

´TransloaditResponse* response =[transloadit deleteAssembly:@"YOUR-CREATED-ASSEMBLY-ID"]);´

You can handle the response like in case of invoke an assembly.

###2.3. Usage of the logger class###

The SDK provides you the possibility to log information and errors. You can use the default `TransloaditLogger` with logger macros.

- `TRANSLOADIT_LOG_INFO(type,message,...)` - logs information, where `type` is the type of the sender object, `message` is the custom log message with parameters and `parameters` are the parameters of the custom log message
- `TRANSLOADIT_LOG_ERROR_WITH_ERROR_AND_MESSAGE(type,error,message,...)` - logs an error (recommended to use in case of an exception thrown), where the `type` is the type of the sender object, `exception` is the thrown exception, `message` is the custom log message with parameters and `parameters` are the parameters of the custom log message

> **Note: ** `TRANSLOADIT_LOG_ERROR_` macro has more parameter definition

##3. Extend Transloadit iOS API##

The SDK is able to be extended. You can use the interfaces to create your own implementations and you can extend the pre-created classes.

##4. Run unit tests##

To pass all unit tests you need XCTest. Run the test from Xcode 5.

###4.1 Constants Class###

To run the tests you need to fill out the Constants.h file.

- API_KEY Your Transloadit API key
- TEST_IMAGE_ON_SD_CARD test image file path on the SD card
- TEMPLATE_ID template ID
- SECRET_KEY Your secret key.
- SIGNATURE_AUTHENTICATION Using server authentication or not. Same as the server settings.



## Documentation

See <a href="https://github.com/transloadit/ios-sdk/blob/master/README.md">GitHub</a> for the full documentation.