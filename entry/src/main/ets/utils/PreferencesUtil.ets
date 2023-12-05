import data_preferences from '@ohos.data.preferences';
import GlobalContext from './GlobalContext';

const PREFERENCES_NAME = 'wan_android'; // 首选项名字

let preference = null
export default class PreferencesUtil {
  private static instance: PreferencesUtil | null = null;

  private constructor() {
    // 私有构造函数，防止外部直接实例化
    preference = data_preferences.getPreferences(<Context> GlobalContext.getContext()
      .getObject("abilityWant"), PREFERENCES_NAME)
  }

  static getInstance(): PreferencesUtil {
    // 提供获取实例的静态方法
    if (!PreferencesUtil.instance) {
      PreferencesUtil.instance = new PreferencesUtil();
    }
    return PreferencesUtil.instance;
  }

  get(key) {
    return new Promise((resolve, reject) => {
      preference.get(key, 'default').then(value => {
        resolve(value)
      }).catch(err => {
        reject(err)
      })
    })
  }

  put(key, value) {
    return new Promise<void>((resolve, reject) => {
      preference.put(key, value).then(() => {
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  }

  has( key) {
    return new Promise((resolve, reject) => {
      preference.has(key).then(result => {
        resolve(result)
      }).catch(err => {
        reject(err)
      })
    })
  }

  deleteKey(key) {
    return new Promise<void>((resolve, reject) => {
      preference.delete(key).then(() => {
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  }
}

