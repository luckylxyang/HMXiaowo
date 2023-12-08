import geoLocationManager from '@ohos.geoLocationManager';
import hilog from '@ohos.hilog';

const TAG = "LocationUtil"
const LocationUtil = {


  getCurrentLocation(): Promise<any> {
    let requestInfo = {
      'scenario': geoLocationManager.LocationRequestScenario.NAVIGATION,
      'timeInterval': 0,
      'distanceInterval': 0,
      'maxAccuracy': 0
    };
    let promise = new Promise((resolve, reject) =>{
      let locationChange = (err, location) => {
        if (err) {
          reject(err)
        }
        if (location) {
          resolve(location)
        }
      };
      geoLocationManager.getCurrentLocation(requestInfo, locationChange)
    })

    return promise;
  },

  registerLocationChangeListener(){

  }
}

export default LocationUtil;
