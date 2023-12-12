import axios, { AxiosError, AxiosRequestConfig, InternalAxiosRequestConfig } from '@ohos/axios'
import { Api } from '../pages/net/ApiConstants'
import PreferencesUtil from './PreferencesUtil'

let service = axios.create({
  baseURL: Api.baseURL,
  timeout: 6 * 1000,
})

// 添加请求拦截器
service.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  // 对请求数据做点什么
  PreferencesUtil.getInstance().get("cookie")
    .then(data => {
      config.headers.set("Cookie", <string> data)
      return config;
    })
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
});

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
            if (res.data.errorCode !== 0) {
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
  post(url, params?, data?) {
    return new Promise((resolve, reject) => {
      service({
        method: 'post',
        url,
        data: data,
        params,
      })
        .then((res) => {
          if (res.status == 200) {
            if (res?.data?.errorCode !== 0) {
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
    params = {
      params: params
    }
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
