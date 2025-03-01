//
//  STPFixtures.m
//  Stripe
//
//  Created by Ben Guo on 3/28/17.
//  Copyright © 2017 Stripe, Inc. All rights reserved.
//

#import "STPFixtures.h"
#import "STPTestUtils.h"

NSString *const STPTestJSONCustomer = @"Customer";

NSString *const STPTestJSONCard = @"Card";

NSString *const STPTestJSONPaymentIntent = @"PaymentIntent";
NSString *const STPTestJSONSetupIntent = @"SetupIntent";

NSString *const STPTestJSONPaymentMethodCard = @"CardPaymentMethod";
NSString *const STPTestJSONPaymentMethodApplePay = @"ApplePayPaymentMethod";
NSString *const STPTestJSONPaymentMethodBacsDebit = @"BacsDebitPaymentMethod";
NSString *const STPTestJSONSourceBankAccount = @"BankAccount";

NSString *const STPTestJSONSource3DS = @"3DSSource";
NSString *const STPTestJSONSourceAlipay = @"AlipaySource";
NSString *const STPTestJSONSourceBancontact = @"BancontactSource";
NSString *const STPTestJSONSourceCard = @"CardSource";
NSString *const STPTestJSONSourceEPS = @"EPSSource";
NSString *const STPTestJSONSourceGiropay = @"GiropaySource";
NSString *const STPTestJSONSourceiDEAL = @"iDEALSource";
NSString *const STPTestJSONSourceMultibanco = @"MultibancoSource";
NSString *const STPTestJSONSourceP24 = @"P24Source";
NSString *const STPTestJSONSourceSEPADebit = @"SEPADebitSource";
NSString *const STPTestJSONSourceSofort = @"SofortSource";
NSString *const STPTestJSONSourceWeChatPay = @"WeChatPaySource";

@import StripeCore;

@implementation STPFixtures

+ (STPConnectAccountParams *)accountParams {
    STPConnectAccountIndividualParams *params = [STPConnectAccountIndividualParams new];
    return [[STPConnectAccountParams alloc] initWithTosShownAndAccepted:YES
                                                             individual:params];
}

+ (STPAddress *)address {
    STPAddress *address = [STPAddress new];
    address.name = @"Jenny Rosen";
    address.phone = @"5555555555";
    address.email = @"jrosen@example.com";
    address.line1 = @"27 Smith St";
    address.line2 = @"Apt 2";
    address.postalCode = @"10001";
    address.city = @"New York";
    address.state = @"NY";
    address.country = @"US";
    return address;
}

+ (STPBankAccountParams *)bankAccountParams {
    STPBankAccountParams *bankParams = [STPBankAccountParams new];
    // https://stripe.com/docs/testing#account-numbers
    bankParams.accountNumber = @"000123456789";
    bankParams.routingNumber = @"110000000";
    bankParams.country = @"US";
    bankParams.currency = @"usd";
    bankParams.accountNumber = @"Jenny Rosen";
    return bankParams;
}

+ (STPCardParams *)cardParams {
    STPCardParams *cardParams = [STPCardParams new];
    cardParams.number = @"4242424242424242";
    cardParams.expMonth = 10;
    cardParams.expYear = 99;
    cardParams.cvc = @"123";
    return cardParams;
}

+ (STPPaymentMethodCardParams *)paymentMethodCardParams {
    STPPaymentMethodCardParams *cardParams = [STPPaymentMethodCardParams new];
    cardParams.number = @"4242424242424242";
    cardParams.expMonth = @(10);
    cardParams.expYear = @(99);
    cardParams.cvc = @"123";
    return cardParams;
}

+ (STPCard *)card {
    return [STPCard decodedObjectFromAPIResponse:[STPTestUtils jsonNamed:STPTestJSONCard]];
}

+ (STPSource *)cardSource {
    return [STPSource decodedObjectFromAPIResponse:[STPTestUtils jsonNamed:STPTestJSONSourceCard]];
}

+ (STPToken *)cardToken {
    NSDictionary *cardDict = [STPTestUtils jsonNamed:STPTestJSONCard];
    NSDictionary *tokenDict = @{
        @"id": @"id_for_token",
        @"object": @"token",
        @"livemode": @NO,
        @"created": @1353025450.0,
        @"type": @"card",
        @"used": @NO,
        @"card": cardDict
    };
    return [STPToken decodedObjectFromAPIResponse:tokenDict];
}

+ (STPCustomer *)customerWithNoSources {
    return [STPCustomer decodedObjectFromAPIResponse:[STPTestUtils jsonNamed:STPTestJSONCustomer]];
}

+ (STPCustomer *)customerWithSingleCardTokenSource {
    return [STPCustomer decodedObjectFromAPIResponse:[self customerWithSingleCardTokenSourceJSON]];
}

+ (NSDictionary *)customerWithSingleCardTokenSourceJSON {
    NSMutableDictionary *card1 = [[STPTestUtils jsonNamed:STPTestJSONCard] mutableCopy];
    card1[@"id"] = @"card_123";

    NSMutableDictionary *customer = [[STPTestUtils jsonNamed:STPTestJSONCustomer] mutableCopy];
    NSMutableDictionary *sources = [customer[@"sources"] mutableCopy];
    sources[@"data"] = @[card1];
    customer[@"default_source"] = card1[@"id"];
    customer[@"sources"] = sources;

    return customer;
}

+ (STPCustomer *)customerWithSingleCardSourceSource {
    NSMutableDictionary *card1 = [[STPTestUtils jsonNamed:STPTestJSONSourceCard] mutableCopy];
    card1[@"id"] = @"card_123";

    NSMutableDictionary *customer = [[STPTestUtils jsonNamed:STPTestJSONCustomer] mutableCopy];
    NSMutableDictionary *sources = [customer[@"sources"] mutableCopy];
    sources[@"data"] = @[card1];
    customer[@"default_source"] = card1[@"id"];
    customer[@"sources"] = sources;

    return [STPCustomer decodedObjectFromAPIResponse:customer];
}

+ (STPCustomer *)customerWithCardTokenAndSourceSources {
    NSMutableDictionary *card1 = [[STPTestUtils jsonNamed:STPTestJSONCard] mutableCopy];
    card1[@"id"] = @"card_123";

    NSMutableDictionary *card2 = [[STPTestUtils jsonNamed:STPTestJSONSourceCard] mutableCopy];
    card2[@"id"] = @"src_456";

    NSMutableDictionary *customer = [[STPTestUtils jsonNamed:STPTestJSONCustomer] mutableCopy];
    NSMutableDictionary *sources = [customer[@"sources"] mutableCopy];
    sources[@"data"] = @[card1, card2];
    customer[@"default_source"] = card1[@"id"];
    customer[@"sources"] = sources;

    return [STPCustomer decodedObjectFromAPIResponse:customer];

}

+ (STPCustomer *)customerWithCardAndApplePaySources {
    return [STPCustomer decodedObjectFromAPIResponse:[self customerWithCardAndApplePaySourcesJSON]];
}

+ (NSDictionary *)customerWithCardAndApplePaySourcesJSON {
    NSMutableDictionary *card1 = [[STPTestUtils jsonNamed:STPTestJSONSourceCard] mutableCopy];
    card1[@"id"] = @"src_apple_pay_123";
    NSMutableDictionary *cardDict = [card1[@"card"] mutableCopy];
    cardDict[@"tokenization_method"] = @"apple_pay";
    card1[@"card"] = cardDict;

    NSMutableDictionary *card2 = [[STPTestUtils jsonNamed:STPTestJSONSourceCard] mutableCopy];
    card2[@"id"] = @"src_card_456";

    NSMutableDictionary *customer = [[STPTestUtils jsonNamed:STPTestJSONCustomer] mutableCopy];
    NSMutableDictionary *sources = [customer[@"sources"] mutableCopy];
    sources[@"data"] = @[card1, card2];
    customer[@"default_source"] = card1[@"id"];
    customer[@"sources"] = sources;

    return customer;
}

+ (STPCustomer *)customerWithSourcesFromJSONKeys:(NSArray<NSString *> *)jsonSourceKeys
                                   defaultSource:(NSString *)jsonKeyForDefaultSource {
    NSMutableArray *sourceJSONDicts = [NSMutableArray new];
    NSString *defaultSourceID = nil;
    NSUInteger sourceCount = 0;
    for (NSString *jsonKey in jsonSourceKeys) {
        NSMutableDictionary *sourceDict = [[STPTestUtils jsonNamed:jsonKey] mutableCopy];
        sourceDict[@"id"] = [NSString stringWithFormat:@"%@", @(sourceCount)];
        if ([jsonKeyForDefaultSource isEqualToString:jsonKey]) {
            defaultSourceID = sourceDict[@"id"];
        }
        sourceCount += 1;
        [sourceJSONDicts addObject:sourceDict.copy];
    }

    NSMutableDictionary *customer = [[STPTestUtils jsonNamed:STPTestJSONCustomer] mutableCopy];
    NSMutableDictionary *sources = [customer[@"sources"] mutableCopy];
    sources[@"data"] = sourceJSONDicts.copy;
    customer[@"default_source"] = defaultSourceID ?: @"";
    customer[@"sources"] = sources;

    return [STPCustomer decodedObjectFromAPIResponse:customer];
}

+ (STPSource *)iDEALSource {
    return [STPSource decodedObjectFromAPIResponse:[STPTestUtils jsonNamed:STPTestJSONSourceiDEAL]];
}

+ (STPSource *)alipaySource {
    return [STPSource decodedObjectFromAPIResponse:[STPTestUtils jsonNamed:STPTestJSONSourceAlipay]];
}

+ (STPSource *)alipaySourceWithNativeURL {
    NSMutableDictionary *dictionary = [STPTestUtils jsonNamed:STPTestJSONSourceAlipay].mutableCopy;
    NSMutableDictionary *detailsDictionary = ((NSDictionary *)dictionary[@"alipay"]).mutableCopy;
    detailsDictionary[@"native_url"] = @"alipay://test";
    dictionary[@"alipay"] = detailsDictionary;
    return [STPSource decodedObjectFromAPIResponse:dictionary];
}

+ (STPSource *)weChatPaySource {
    return [STPSource decodedObjectFromAPIResponse:[STPTestUtils jsonNamed:STPTestJSONSourceWeChatPay]];
}

+ (STPPaymentIntent *)paymentIntent {
    return [STPPaymentIntent decodedObjectFromAPIResponse:[STPTestUtils jsonNamed:@"PaymentIntent"]];
}

+ (STPSetupIntent *)setupIntent {
    return [STPSetupIntent decodedObjectFromAPIResponse:[STPTestUtils jsonNamed:@"SetupIntent"]];
}

+ (STPPaymentConfiguration *)paymentConfiguration {
    STPPaymentConfiguration *config = [STPPaymentConfiguration new];
    return config;
}

+ (PKPaymentRequest *)applePayRequest {
    PKPaymentRequest *paymentRequest = [StripeAPI paymentRequestWithMerchantIdentifier:@"foo" country:@"US" currency:@"USD"];
    paymentRequest.paymentSummaryItems = @[[PKPaymentSummaryItem summaryItemWithLabel:@"bar" amount:[NSDecimalNumber decimalNumberWithString:@"10.00"]]];
    return paymentRequest;
}

+ (PKPayment *)simulatorApplePayPayment {
    PKPayment *payment = [PKPayment new];
    PKPaymentToken *paymentToken = [PKPaymentToken new];
    PKPaymentMethod *paymentMethod = [PKPaymentMethod new];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [paymentMethod performSelector:@selector(setDisplayName:) withObject:@"Simulated Instrument"];
    [paymentMethod performSelector:@selector(setNetwork:) withObject:@"AmEx"];
    [paymentToken performSelector:@selector(setTransactionIdentifier:) withObject:@"Simulated Identifier"];
    
    [paymentToken performSelector:@selector(setPaymentMethod:) withObject:paymentMethod];

    [payment performSelector:@selector(setToken:) withObject:paymentToken];
    
    // Add shipping
    PKContact *shipping = [PKContact new];
    shipping.name = [[NSPersonNameComponentsFormatter new] personNameComponentsFromString:@"Jane Doe"];
    CNMutablePostalAddress *address = [CNMutablePostalAddress new];
    address.street = @"510 Townsend St";
    shipping.postalAddress = address;
    [payment performSelector:@selector(setShippingContact:) withObject:shipping];
#pragma clang diagnostic pop
    return payment;
}

+ (PKPayment *)applePayPayment {
    PKPayment *payment = [PKPayment new];
    PKPaymentToken *paymentToken = [PKPaymentToken new];
    NSString *tokenDataString = @"{\"version\":\"EC_v1\",\"data\":\"lF8RBjPvhc2GuhjEh7qFNijDJjxD/ApmGdQhgn8tpJcJDOwn2E1BkOfSvnhrR8BUGT6+zeBx8OocvalHZ5ba/WA/"
    @"tDxGhcEcOMp8sIJrXMVcJ6WqT5P1ZY+utmdORhxyH4nUw2wuEY4lAE7/GtEU/RNDhaKx/"
    @"m93l0oLlk84qD1ynTA5JP3gjkdX+RK23iCAZDScXCcCU0OnYlJV8sDyf3+8hIo0gpN43AxoY6N1xAsVbGsO4ZjSCahaXbgt0egFug3s7Fyt9W4uzu07SKKCA2+"
    @"DNZeZeerefpN1d1YbiCNlxFmffZKLCGdFERc7Ci3+yrHWWnYhKdQh8FeKCiiAvY5gbZJgQ91lNumCuP1IkHdHqxYI0qFk9c2R6KStJDtoUbVEYbxwnGdEJJPiMPjuKlgi7E+"
    @"LlBdXiREmlz4u1EA=\",\"signature\":"
    @"\"MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIID4jCCA4igAwIBAgIIJEPyqAad9XcwCgYIKoZIzj0EAwIwejEuMCwGA1UEAwwlQXBwbGUgQX"
    @"BwbGljYXRpb24gSW50ZWdyYXRpb24gQ0EgLSBHMzEmMCQGA1UECwwdQXBwbGUgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxEzARBgNVBAoMCkFwcGxlIEluYy4xCzAJBgNVBAYTAlVTMB4XDTE0MD"
    @"kyNTIyMDYxMVoXDTE5MDkyNDIyMDYxMVowXzElMCMGA1UEAwwcZWNjLXNtcC1icm9rZXItc2lnbl9VQzQtUFJPRDEUMBIGA1UECwwLaU9TIFN5c3RlbXMxEzARBgNVBAoMCkFwcGxlIEluYy4xCz"
    @"AJBgNVBAYTAlVTMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEwhV37evWx7Ihj2jdcJChIY3HsL1vLCg9hGCV2Ur0pUEbg0IO2BHzQH6DMx8cVMP36zIg1rrV1O/"
    @"0komJPnwPE6OCAhEwggINMEUGCCsGAQUFBwEBBDkwNzA1BggrBgEFBQcwAYYpaHR0cDovL29jc3AuYXBwbGUuY29tL29jc3AwNC1hcHBsZWFpY2EzMDEwHQYDVR0OBBYEFJRX22/"
    @"VdIGGiYl2L35XhQfnm1gkMAwGA1UdEwEB/wQCMAAwHwYDVR0jBBgwFoAUI/JJxE+T5O8n5sT2KGw/orv9LkswggEdBgNVHSAEggEUMIIBEDCCAQwGCSqGSIb3Y2QFATCB/"
    @"jCBwwYIKwYBBQUHAgIwgbYMgbNSZWxpYW5jZSBvbiB0aGlzIGNlcnRpZmljYXRlIGJ5IGFueSBwYXJ0eSBhc3N1bWVzIGFjY2VwdGFuY2Ugb2YgdGhlIHRoZW4gYXBwbGljYWJsZSBzdGFuZGFyZ"
    @"CB0ZXJtcyBhbmQgY29uZGl0aW9ucyBvZiB1c2UsIGNlcnRpZmljYXRlIHBvbGljeSBhbmQgY2VydGlmaWNhdGlvbiBwcmFjdGljZSBzdGF0ZW1lbnRzLjA2BggrBgEFBQcCARYqaHR0cDovL3d3d"
    @"y5hcHBsZS5jb20vY2VydGlmaWNhdGVhdXRob3JpdHkvMDQGA1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuYXBwbGUuY29tL2FwcGxlYWljYTMuY3JsMA4GA1UdDwEB/"
    @"wQEAwIHgDAPBgkqhkiG92NkBh0EAgUAMAoGCCqGSM49BAMCA0gAMEUCIHKKnw+Soyq5mXQr1V62c0BXKpaHodYu9TWXEPUWPpbpAiEAkTecfW6+"
    @"W5l0r0ADfzTCPq2YtbS39w01XIayqBNy8bEwggLuMIICdaADAgECAghJbS+/"
    @"OpjalzAKBggqhkjOPQQDAjBnMRswGQYDVQQDDBJBcHBsZSBSb290IENBIC0gRzMxJjAkBgNVBAsMHUFwcGxlIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MRMwEQYDVQQKDApBcHBsZSBJbmMuMQsw"
    @"CQYDVQQGEwJVUzAeFw0xNDA1MDYyMzQ2MzBaFw0yOTA1MDYyMzQ2MzBaMHoxLjAsBgNVBAMMJUFwcGxlIEFwcGxpY2F0aW9uIEludGVncmF0aW9uIENBIC0gRzMxJjAkBgNVBAsMHUFwcGxlIENl"
    @"cnRpZmljYXRpb24gQXV0aG9yaXR5MRMwEQYDVQQKDApBcHBsZSBJbmMuMQswCQYDVQQGEwJVUzBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABPAXEYQZ12SF1RpeJYEHduiAou/"
    @"ee65N4I38S5PhM1bVZls1riLQl3YNIk57ugj9dhfOiMt2u2ZwvsjoKYT/"
    @"VEWjgfcwgfQwRgYIKwYBBQUHAQEEOjA4MDYGCCsGAQUFBzABhipodHRwOi8vb2NzcC5hcHBsZS5jb20vb2NzcDA0LWFwcGxlcm9vdGNhZzMwHQYDVR0OBBYEFCPyScRPk+TvJ+bE9ihsP6K7/"
    @"S5LMA8GA1UdEwEB/"
    @"wQFMAMBAf8wHwYDVR0jBBgwFoAUu7DeoVgziJqkipnevr3rr9rLJKswNwYDVR0fBDAwLjAsoCqgKIYmaHR0cDovL2NybC5hcHBsZS5jb20vYXBwbGVyb290Y2FnMy5jcmwwDgYDVR0PAQH/"
    @"BAQDAgEGMBAGCiqGSIb3Y2QGAg4EAgUAMAoGCCqGSM49BAMCA2cAMGQCMDrPcoNRFpmxhvs1w1bKYr/0F+3ZD3VNoo6+8ZyBXkK3ifiY95tZn5jVQQ2PnenC/gIwMi3VRCGwowV3bF3zODuQZ/"
    @"0XfCwhbZZPxnJpghJvVPh6fRuZy5sJiSFhBpkPCZIdAAAxggFeMIIBWgIBATCBhjB6MS4wLAYDVQQDDCVBcHBsZSBBcHBsaWNhdGlvbiBJbnRlZ3JhdGlvbiBDQSAtIEczMSYwJAYDVQQLDB1BcH"
    @"BsZSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTETMBEGA1UECgwKQXBwbGUgSW5jLjELMAkGA1UEBhMCVVMCCCRD8qgGnfV3MA0GCWCGSAFlAwQCAQUAoGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQ"
    @"EHATAcBgkqhkiG9w0BCQUxDxcNMTQxMjIyMDIxMzQyWjAvBgkqhkiG9w0BCQQxIgQgUak8LCvAswLOnY2vlZf/"
    @"iG3q04omAr3zV8YTtqvORGYwCgYIKoZIzj0EAwIERjBEAiAuPXMqEQqiTjYadOAvNmohP2yquB4owoQNjuAETkFXMAIgcH6zOxnbTTFmlEocqMztWR+L6OVBH6iTPIFMBNPcq6gAAAAAAAA=\","
    @"\"header\":{\"transactionId\":\"a530c7d68b6a69791d8864df2646c8aa3d09d33b56d8f8162ab23e1b26afe5e9\",\"ephemeralPublicKey\":"
    @"\"MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEhKpIc6wTNQGy39bHM0a0qziDb20jMBFZT9XKSdjGULpDGRdyil6MLwMyIf3lQxaV/"
    @"P7CQztw28IvYozvKvjBPQ==\",\"publicKeyHash\":\"yRcyn7njT6JL3AY9nmg0KD/xm/ch7gW1sGl2OuEucZY=\"}}";
    NSData *data = [tokenDataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSPersonNameComponents *nameComponents = [[NSPersonNameComponents alloc] init];
    [nameComponents setGivenName:@"Test"];
    [nameComponents setFamilyName:@"Testerson"];
    PKContact *contact = [[PKContact alloc] init];
    contact.name = nameComponents;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    // Add a fake display name
    PKPaymentMethod *paymentMethod = [[PKPaymentMethod alloc] init];
    [paymentMethod performSelector:@selector(setDisplayName:) withObject:@"Master Charge"];

    [paymentToken performSelector:@selector(setPaymentMethod:) withObject:paymentMethod];
    
    [paymentToken performSelector:@selector(setPaymentData:) withObject:data];
    [payment performSelector:@selector(setToken:) withObject:paymentToken];
    [payment performSelector:@selector(setBillingContact:) withObject:contact];
#pragma clang diagnostic pop
    return payment;
}

#pragma mark - Payment Method

+ (STPPaymentMethod *)paymentMethod {
    return [STPPaymentMethod decodedObjectFromAPIResponse:[self paymentMethodJSON]];
}

+ (NSDictionary *)paymentMethodJSON {
    return [STPTestUtils jsonNamed:STPTestJSONPaymentMethodCard];
}

+ (STPPaymentMethod *)applePayPaymentMethod {
    return [STPPaymentMethod decodedObjectFromAPIResponse:[self applePayPaymentMethodJSON]];
}

+ (NSDictionary *)applePayPaymentMethodJSON {
    return [STPTestUtils jsonNamed:STPTestJSONPaymentMethodApplePay];
}
+ (STPPaymentMethod *)bankAccountPaymentMethod {
    return [STPPaymentMethod decodedObjectFromAPIResponse:[self bankAccountPaymentMethodJSON]];
}
+ (NSDictionary *)bankAccountPaymentMethodJSON {
    return [STPTestUtils jsonNamed:STPTestJSONSourceBankAccount];
}

@end
