import promptAction from '@ohos.promptAction'
import { Permissions } from '@ohos.abilityAccessCtrl'
import PermissionUtil from '../../utils/PermissionUtil'
import CommonWeb from './CommonWeb'
import hilog from '@ohos.hilog'

@Component
export default struct Map {
  private  permissions : Array<Permissions> = ['ohos.permission.APPROXIMATELY_LOCATION','ohos.permission.LOCATION']

  aboutToAppear() {
    //
    PermissionUtil.checkPermissions(this.permissions)
      .then(data => {
        promptAction.showToast({ message: "授权成功" })
      }).catch(err => {

      PermissionUtil.reqPermissionsFromUser(this.permissions)
        .then(([all, agree, refuse])=>{
          if (all) {
            promptAction.showToast({ message: "授权成功" })
          }else{
            hilog.info(0XFFF, "permission", JSON.stringify(refuse))
            promptAction.showToast({ message: "拒绝授权" })
          }
        }).catch(err=>{
        promptAction.showToast({ message: "拒绝授权" })
      })

    })
  }

  build() {
    CommonWeb({ url: "http://221.181.158.12:8081/ydyzt/?system=YZYDYZT&hheader=true&loginName=admin#/", title: "地图" })
  }
}