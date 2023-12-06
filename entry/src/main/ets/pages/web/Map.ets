import promptAction from '@ohos.promptAction'
import { Permissions } from '@ohos.abilityAccessCtrl'
import PermissionUtil from '../../utils/PermissionUtil'
import CommonWeb from './CommonWeb'

@Component
export default struct Map {
  private  permissions : Array<Permissions> = ['ohos.permission.APPROXIMATELY_LOCATION','ohos.permission.LOCATION']

  aboutToAppear() {
    //
    PermissionUtil.checkPermissions(this.permissions)
      .then(data => {
        promptAction.showToast({ message: "授权成功" })
      }).catch(err => {
      promptAction.showToast({ message: "未授权" })
      PermissionUtil.reqPermissionsFromUser(this.permissions)

    })
  }

  build() {
    CommonWeb({ url: "http://192.168.5.108:8081/ydyzt/?system=YZYDYZT#/", title: "地图" })
  }
}