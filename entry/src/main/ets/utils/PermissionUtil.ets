import bundleManager from '@ohos.bundle.bundleManager';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import common from '@ohos.app.ability.common';

const PermissionUtil = {

  /**
   * 获取
   * @param permission
   * @returns
   */
  checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    let atManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus;

    // 获取应用程序的accessTokenID
    return new Promise((resolve, reject) => {
      bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
        .then(bundleInfo => {
          let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
          let tokenId = appInfo.accessTokenId;

          // 校验应用是否被授予权限
          atManager.checkAccessToken(tokenId, permission)
            .then(data => {
              resolve(data)
            })
            .catch(err => {
              reject(err)
            })
        }).catch(error => {
        reject(error)
      })
    })

  },

  /**
   * 验证权限是否已授权
   * @param permiss
   * @returns
   */
  checkPermissions(permissions: Permissions): Promise<void> {
    return new Promise((resolve, reject) => {
      let grantStatus: abilityAccessCtrl.GrantStatus = this.checkAccessToken(permissions);

      if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        // 已经授权，可以继续访问目标操作
        resolve()
      } else {
        // 未授权或拒绝授权
        reject()
      }
    })
  },

  /**
   * 申请权限
   * @param permissions
   */
  reqPermissionsFromUser(permissions: Array<Permissions>): Promise<[boolean, Array<Permissions>, Array<Permissions>]> {
    console.info("开始授权")
    let context = getContext(this) as common.UIAbilityContext;
    let atManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    return new Promise((resolve, reject) =>{
      atManager.requestPermissionsFromUser(context, permissions).then((data) => {
        let grantStatus: Array<number> = data.authResults;
        let length: number = grantStatus.length;
        let allAgree = false;
        let agreePermission = []
        let refusePermission = []
        for (let i = 0; i < length; i++) {
          if (grantStatus[i] === 0) {
            // 用户授权，可以继续访问目标操作
            agreePermission.push(permissions[i])
          } else {
            // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
            refusePermission.push(permissions[i])
          }
        }

        if (agreePermission.length == permissions.length) {
          allAgree = true
        }
        resolve([allAgree, agreePermission, refusePermission])

      }).catch((err) => {
        resolve(err)
      })
    })
  }
}

export default PermissionUtil;
