//
//  Locationmanager.swift
//  EventLocatorApp
//
//  Created by Lakshmi Prasanna Garine on 1/9/19.
//  Copyright © 2019 Lakshmi Prasanna Garine. All rights reserved.
//

import UIKit
import CoreLocation

class Locationmanager: NSObject,CLLocationManagerDelegate {
    
    enum LocationErrors:String {
        case denied = "Locations are turned off. Please turn it on in Settings"
        case restricted = "Locations are restricted"
        case notDetermined = "Locations are not determined yet"
        case notFetched = "Unable to fetch location"
        case invalidLocation = "Invalid Location"
        case reverseGeocodingFailed = "Reverse Geocoding Failed"
    }
    
    //Time allowed to fetch the location continuously for accuracy
    private var locationFetchTimeInseconds = 1.0
    
    private var locationManager:CLLocationManager?
    var locationAccuracy = kCLLocationAccuracyBest
    
    typealias LocationClosure = ((_ location:CLLocation?,  _ error:NSError?)->Void)
    private var locationCompletionHandler: LocationClosure?
    
    typealias resverseGeoLocationClosure = ((_ location:CLLocation?, _ placemark:CLPlacemark?, _ error:NSError?)->Void)
    private var geoLocationCompletionHandler:resverseGeoLocationClosure?
    
    private var lastlocation:CLLocation?
    private var reverseGeoCoding = false
    
    
    //singleton Instance for locationManager
    
    static let sharedInstance: Locationmanager = {
        
        let instance = Locationmanager()
        
        return instance
        
    }()
    
    private func setupLocationmanager()
    {
        //setup location manager
        locationManager=nil
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy=locationAccuracy
        locationManager?.requestWhenInUseAuthorization()
    }
    
    //MARK:- Selectors
    private func startThread() {
        self.perform(#selector(sendLocation), with: nil, afterDelay: locationFetchTimeInseconds)
    }
    
    private func startGeocodeThread() {
        self.perform(#selector(sendPlacemark), with: nil, afterDelay: locationFetchTimeInseconds)
    }
    
    @objc private func sendPlacemark() {
        guard let _ = lastlocation else {
            
            self.didCompletegeocoding(location: nil, placemark: nil, error: NSError(
                domain: self.classForCoder.description(),
                code:Int(CLAuthorizationStatus.denied.rawValue),
                userInfo:
                [NSLocalizedDescriptionKey:LocationErrors.notFetched.rawValue,
                 NSLocalizedFailureReasonErrorKey:LocationErrors.notFetched.rawValue,
                 NSLocalizedRecoverySuggestionErrorKey:LocationErrors.notFetched.rawValue]))
            
            lastlocation = nil
            return
        }
        
        self.reverseGeoCoding(location: lastlocation)
        lastlocation = nil
    }
   
    //MARK:-Selectors
    
    @objc private func sendLocation()
    {
        guard let _ = lastlocation else {
            
            self.didComplete(location: nil, error: NSError(domain: self.classForCoder.description(), code: Int(CLAuthorizationStatus.denied.rawValue), userInfo: [NSLocalizedDescriptionKey:LocationErrors.notFetched.rawValue,NSLocalizedFailureReasonErrorKey:LocationErrors.notFetched.rawValue,NSLocalizedRecoverySuggestionErrorKey:LocationErrors.notFetched.rawValue]))
            lastlocation = nil
            return
            
        }
        self.didComplete(location: lastlocation, error: nil)
        lastlocation = nil
    }
    
    //MARK:- Public Methods
    
    /// Change the fetch waiting time for location. Default is 1 second
    ///
    /// - Parameter seconds: seconds given for GPS to fetch location
    func setTimerForLocation(seconds:Double) {
        locationFetchTimeInseconds = seconds
    }
    
    /// Get current location
    ///
    /// - Parameter completionHandler: will return CLLocation object which is the current location of the user and NSError in case of error
    
    
    func getLocation(completionHandler:@escaping LocationClosure){
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        //resetting last location
        lastlocation = nil
        
        self.locationCompletionHandler = completionHandler
        
        setupLocationmanager()
        
    }
    
    /// Get Reverse Geocoded Placemark address by passing CLLocation
    ///
    /// - Parameters:
    ///   - location: location Passed which is a CLLocation object
    ///   - completionHandler: will return CLLocation object and CLPlacemark of the CLLocation and NSError in case of error
    
    func getReverseGeoCodedLocation(location:CLLocation,completionHandler:@escaping resverseGeoLocationClosure) {
        
        //Cancelling the previous selector handlers if any
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        self.geoLocationCompletionHandler = nil
        self.geoLocationCompletionHandler = completionHandler
        if !reverseGeoCoding {
            reverseGeoCoding = true
            self.reverseGeoCoding(location: location)
        }
        
    }
    
    /// Get Latitude and Longitude of the address as CLLocation object
    ///
    /// - Parameters:
    ///   - address: address given by the user in String
    ///   - completionHandler: will return CLLocation object and CLPlacemark of the address entered and NSError in case of error
    func getReverseGeoCodedLocation(address:String,completionHandler:@escaping resverseGeoLocationClosure) {
        
        //Cancelling the previous selector handlers if any
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        self.geoLocationCompletionHandler = nil
        self.geoLocationCompletionHandler = completionHandler
        if !reverseGeoCoding {
            reverseGeoCoding = true
            self.reverseGeoCoding(address: address)
        }
    }
    
    /// Get current location with placemark
    ///
    /// - Parameter completionHandler: will return Location,Placemark and error
    func getCurrentReverseGeoCodedLocation(completionHandler:@escaping resverseGeoLocationClosure) {
        
        if !reverseGeoCoding {
            
            reverseGeoCoding = true
            
            //Cancelling the previous selector handlers if any
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            
            //Resetting last location
            lastlocation = nil
            
            self.geoLocationCompletionHandler = completionHandler
            
            setupLocationmanager()
        }
    }

    
    private func reverseGeoCoding(location:CLLocation?) {
        CLGeocoder().reverseGeocodeLocation(location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                //Reverse geocoding failed
                self.didCompletegeocoding(location: nil, placemark: nil, error: NSError(
                    domain: self.classForCoder.description(),
                    code:Int(CLAuthorizationStatus.denied.rawValue),
                    userInfo:
                    [NSLocalizedDescriptionKey:LocationErrors.reverseGeocodingFailed.rawValue,
                     NSLocalizedFailureReasonErrorKey:LocationErrors.reverseGeocodingFailed.rawValue,
                     NSLocalizedRecoverySuggestionErrorKey:LocationErrors.reverseGeocodingFailed.rawValue]))
                return
            }
            if placemarks!.count > 0 {
                let placemark = placemarks![0]
                if let _ = location {
                    self.didCompletegeocoding(location: location, placemark: placemark, error: nil)
                } else {
                    self.didCompletegeocoding(location: nil, placemark: nil, error: NSError(
                        domain: self.classForCoder.description(),
                        code:Int(CLAuthorizationStatus.denied.rawValue),
                        userInfo:
                        [NSLocalizedDescriptionKey:LocationErrors.invalidLocation.rawValue,
                         NSLocalizedFailureReasonErrorKey:LocationErrors.invalidLocation.rawValue,
                         NSLocalizedRecoverySuggestionErrorKey:LocationErrors.invalidLocation.rawValue]))
                }
                if(!CLGeocoder().isGeocoding){
                    CLGeocoder().cancelGeocode()
                }
            }else{
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    
    private func reverseGeoCoding(address:String) {
        CLGeocoder().geocodeAddressString(address, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                //Reverse geocoding failed
                self.didCompletegeocoding(location: nil, placemark: nil, error: NSError(
                    domain: self.classForCoder.description(),
                    code:Int(CLAuthorizationStatus.denied.rawValue),
                    userInfo:
                    [NSLocalizedDescriptionKey:LocationErrors.reverseGeocodingFailed.rawValue,
                     NSLocalizedFailureReasonErrorKey:LocationErrors.reverseGeocodingFailed.rawValue,
                     NSLocalizedRecoverySuggestionErrorKey:LocationErrors.reverseGeocodingFailed.rawValue]))
                return
            }
            if placemarks!.count > 0 {
                if let placemark = placemarks?[0] {
                    self.didCompletegeocoding(location: placemark.location, placemark: placemark, error: nil)
                } else {
                    self.didCompletegeocoding(location: nil, placemark: nil, error: NSError(
                        domain: self.classForCoder.description(),
                        code:Int(CLAuthorizationStatus.denied.rawValue),
                        userInfo:
                        [NSLocalizedDescriptionKey:LocationErrors.invalidLocation.rawValue,
                         NSLocalizedFailureReasonErrorKey:LocationErrors.invalidLocation.rawValue,
                         NSLocalizedRecoverySuggestionErrorKey:LocationErrors.invalidLocation.rawValue]))
                }
                if(!CLGeocoder().isGeocoding){
                    CLGeocoder().cancelGeocode()
                }
            }else{
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    
    //MARK:- CLLocationManager Delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastlocation = locations.last
        
        //Manager is stopped as per the timer given
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .authorizedWhenInUse,.authorizedAlways:
            self.locationManager?.startUpdatingLocation()
            if self.reverseGeoCoding {
                startGeocodeThread()
            } else {
                startThread()
            }
            
        case .denied:
            let deniedError = NSError(
                domain: self.classForCoder.description(),
                code:Int(CLAuthorizationStatus.denied.rawValue),
                userInfo:
                [NSLocalizedDescriptionKey:LocationErrors.denied.rawValue,
                 NSLocalizedFailureReasonErrorKey:LocationErrors.denied.rawValue,
                 NSLocalizedRecoverySuggestionErrorKey:LocationErrors.denied.rawValue])
            
            if reverseGeoCoding {
                didCompletegeocoding(location: nil, placemark: nil, error: deniedError)
            } else {
                didComplete(location: nil,error: deniedError)
            }
            
        case .restricted:
            if reverseGeoCoding {
                didComplete(location: nil,error: NSError(
                    domain: self.classForCoder.description(),
                    code:Int(CLAuthorizationStatus.restricted.rawValue),
                    userInfo: nil))
            } else {
                didComplete(location: nil,error: NSError(
                    domain: self.classForCoder.description(),
                    code:Int(CLAuthorizationStatus.restricted.rawValue),
                    userInfo: nil))
            }
            break
            
        case .notDetermined:
            self.locationManager?.requestWhenInUseAuthorization()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        self.didComplete(location: nil, error: error as NSError?)
    }
    
    private func didComplete(location:CLLocation?, error:NSError?){
        locationManager?.stopUpdatingLocation()
       locationCompletionHandler?(location,error)
        locationManager?.delegate=nil
        locationManager=nil
        
    }
    
    private func didCompletegeocoding(location:CLLocation?, placemark:CLPlacemark?, error:NSError?)
    {
        locationManager?.stopUpdatingLocation()
        geoLocationCompletionHandler?(location,placemark,error)
        locationManager?.delegate = nil;
        locationManager = nil;
        reverseGeoCoding = false;
        
    }
    
    //MARK:- Destroying LocationManager
   deinit {
        destroyLocationManager()
     }
    
 private func destroyLocationManager()
 {
    locationManager?.delegate = nil;
    locationManager = nil
    lastlocation = nil
    
    }
    
    

}
