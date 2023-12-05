import axios from '@ohos/axios'
import { Api } from '../pages/net/ApiConstants'

let service = axios.create({
  baseURL: Api.baseURL,
  timeout: 6 * 1000,
})

export default {

  get(url) {
    // params = { params: params }
    return new Promise((resolve, reject) => {
      service({
        method: 'get',
        url,
        // params,
      })
        .then((res) => {
          if (res.status == 200) {
            if(res.data.errorCode !== 0){
              throw new Error(res.data.errorMsg);
            }
            resolve(res.data.data)
          }
        })
        .catch((err) => {
          reject(err)
          console.log(err)
        })
    })
  },
  post(url, params, data) {
    return new Promise((resolve, reject) => {
      service({
        method: 'post',
        url,
        data: data,
        params,
      })
        .then((res) => {
          if (res.status == 200) {
            if(res?.data?.errorCode !== 0){
              throw new Error(res.data.errorMsg);
            }
            resolve(res.data.data)
          }
        })
        .catch((err) => {
          reject(err)
          console.log(err)
        })
    })
  },
  postData(url, params, data) {
    params = { params: params }
    return new Promise((resolve, reject) => {
      service({
        method: 'post',
        url,
        data: data,
        params,
      })
        .then((res) => {
          if (res.status == 200 && res.data.errorCode == 0) {
            resolve(res)
          } else {
            throw new Error(res.data.errorMsg);
          }
        })
        .catch((err) => {
          reject(err)
          console.log(err)
        })
    })
  },

}
