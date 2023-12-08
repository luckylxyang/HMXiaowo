
import LocationUtil from '../../utils/LocationUtil';

export default class jssdk{

  getLocation2(){

    LocationUtil.getCurrentLocation()
      .then(location=>{

        console.log('locationChanger: location=' + JSON.stringify(location));
      }).catch(err=>{
      console.log('locationChanger: location=' + JSON.stringify(err));
    })
  }

  getLocation(){
    return {"longitude":"120.752122","latitude":"31.253465"}
  }
}