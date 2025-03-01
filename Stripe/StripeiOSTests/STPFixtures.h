//
//  STPFixtures.h
//  Stripe
//
//  Created by Ben Guo on 3/28/17.
//  Copyright © 2017 Stripe, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OCMock/OCMock.h>
#import <PassKit/PassKit.h>
@import Stripe;
@import StripeCore;
@import StripePayments;
@import StripePaymentsUI;

NS_ASSUME_NONNULL_BEGIN
extern NSString *const STPTestJSONCustomer;

extern NSString *const STPTestJSONCard;

extern NSString *const STPTestJSONPaymentIntent;
extern NSString *const STPTestJSONSetupIntent;
extern NSString *const STPTestJSONPaymentMethodCard;
extern NSString *const STPTestJSONPaymentMethodApplePay;
extern NSString *const STPTestJSONPaymentMethodBacsDebit;

extern NSString *const STPTestJSONSource3DS;
extern NSString *const STPTestJSONSourceAlipay;
extern NSString *const STPTestJSONSourceBancontact;
extern NSString *const STPTestJSONSourceCard;
extern NSString *const STPTestJSONSourceEPS;
extern NSString *const STPTestJSONSourceGiropay;
extern NSString *const STPTestJSONSourceiDEAL;
extern NSString *const STPTestJSONSourceMultibanco;
extern NSString *const STPTestJSONSourceP24;
extern NSString *const STPTestJSONSourceSEPADebit;
extern NSString *const STPTestJSONSourceSofort;

@interface STPFixtures : NSObject

/**
 An STPConnectAccountParams object with all of the fields filled in, and
 ToS accepted.
 */
+ (STPConnectAccountParams *)accountParams;

/**
 An Address object with all fields filled.
 */
+ (STPAddress *)address;

/**
 A PKPaymentObject with test payment data.
 */
+ (PKPayment *)applePayPayment;

/**
 A PKPayment from the simulator that can be tokenized in testmode.
 */
+ (PKPayment *)simulatorApplePayPayment;

/**
 A valid PKPaymentRequest with dummy data.
 */
+ (PKPaymentRequest *)applePayRequest;

/**
 A BankAccountParams object with all fields filled.
 */
+ (STPBankAccountParams *)bankAccountParams;

/**
 A CardParams object with a valid number, expMonth, expYear, and cvc.
 */
+ (STPCardParams *)cardParams;

/**
 A valid card object
 */
+ (STPCard *)card;

/**
 A Source object with type card
 */
+ (STPSource *)cardSource;

/**
 A Token for a card
 */
+ (STPToken *)cardToken;

/**
 A Customer object with an empty sources array.
 */
+ (STPCustomer *)customerWithNoSources;

/**
 A Customer object with a single card token in its sources array, and
 default_source set to that card token.
 */
+ (STPCustomer *)customerWithSingleCardTokenSource;

/**
 The JSON data for a Customer with a single card token in its sources array, and
 default_source set to that card token.
 */
+ (NSDictionary *)customerWithSingleCardTokenSourceJSON;

/**
 A Customer object with a single card source in its sources array, and
 default_source set to that card source.
 */
+ (STPCustomer *)customerWithSingleCardSourceSource;

/**
 A Customer object with two cards in its sources array, 
 one a token/card type and one a source object type.
 default_source is set to the card token.
 */
+ (STPCustomer *)customerWithCardTokenAndSourceSources;

/**
 A Customer object with a card source, and apple pay card source, and
 default_source set to the apple pay source.
 */
+ (STPCustomer *)customerWithCardAndApplePaySources;

/**
 A Customer JSON blob with a card source, and apple pay card source, and
 default_source set to the apple pay source.
 */
+ (NSDictionary *)customerWithCardAndApplePaySourcesJSON;

/**
 A customer object with a sources array that includes the listed json sources
 in the order they are listed in the array.
 
 Valid keys are any STPTestJSONSource constants and the STPTestJSONCard constant.
 
 Ids for the sources will be automatically generated and will be equal to a
 string that is the index of the array of that source.
 */
+ (STPCustomer *)customerWithSourcesFromJSONKeys:(NSArray<NSString *> *)jsonSourceKeys
                                   defaultSource:(NSString *)jsonKeyForDefaultSource;

/**
 A Source object with type iDEAL
 */
+ (STPSource *)iDEALSource;

/**
 A Source object with type Alipay
 */
+ (STPSource *)alipaySource;

/**
 A Source object with type WeChat Pay
 */
+ (STPSource *)weChatPaySource;
    
/**
 A Source object with type Alipay and a native redirect url
 */
+ (STPSource *)alipaySourceWithNativeURL;

/**
 A PaymentIntent object
 */
+ (STPPaymentIntent *)paymentIntent;

/**
 A SetupIntent object
 */
+ (STPSetupIntent *)setupIntent;

/**
 A PaymentConfiguration object with a fake publishable key. Use this to avoid
 triggering our asserts when publishable key is nil or invalid. All other values
 are at their original defaults.
 */
+ (STPPaymentConfiguration *)paymentConfiguration;

/**
 A PaymentMethod object
 */
+ (STPPaymentMethod *)paymentMethod;

/**
 A PaymentMethod JSON dictionary
 */
+ (NSDictionary *)paymentMethodJSON;

/**
 A STPPaymentMethodCardParams object with a valid number, expMonth, expYear, and cvc.
 */
+ (STPPaymentMethodCardParams *)paymentMethodCardParams;

/**
 An Apple Pay Payment Method object.
 */
+ (STPPaymentMethod *)applePayPaymentMethod;

/**
 An Apple Pay Payment Method JSON dictionary.
 */
+ (NSDictionary *)applePayPaymentMethodJSON;

/**
   Bank account payment method
 */
+ (STPPaymentMethod *)bankAccountPaymentMethod;

/**
   Bank account payment payment method JSON Dictionary
 */
+ (NSDictionary *)bankAccountPaymentMethodJSON;

@end

@interface STPJsonSources : NSObject

@end

NS_ASSUME_NONNULL_END
