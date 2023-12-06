import bundleManager from '@ohos.bundle.bundleManager';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import common from '@ohos.app.ability.common';

const PermissionUtil = {

  /**
   * 获取
   * @param permission
   * @returns
   */
  async checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    let atManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus;

    // 获取应用程序的accessTokenID
    let tokenId: number;
    try {
      let bundleInfo: bundleManager.BundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId;
    } catch (err) {
      console.error(`getBundleInfoForSelf failed, code is ${err.code}, message is ${err.message}`);
    }

    // 校验应用是否被授予权限
    try {
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (err) {
      console.error(`checkAccessToken failed, code is ${err.code}, message is ${err.message}`);
    }

    return grantStatus;
  },

  /**
   * 验证权限是否已授权
   * @param permiss
   * @returns
   */
  async checkPermissions(permissions: Array<Permissions>): Promise<void> {
    return new Promise((resolve, reject) => {
      let grantStatus: abilityAccessCtrl.GrantStatus = await this.checkAccessToken(permissions[0]);

      if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        // 已经授权，可以继续访问目标操作
        resolve()
      } else {
        // 申请日历权限
        reject()
      }
    })
  },

  /**
   * 申请权限
   * @param permissions
   */
  reqPermissionsFromUser(permissions: Array<Permissions>): void {
    let context = getContext(this) as common.UIAbilityContext;
    let atManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    atManager.requestPermissionsFromUser(context, permissions).then((data) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      for (let i = 0; i < length; i++) {
        if (grantStatus[i] === 0) {
          // 用户授权，可以继续访问目标操作
          console.info("授权成功")
        } else {
          // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
          console.info("授权拒绝")
          return;
        }
      }
      // 授权成功
    }).catch((err) => {
      console.error(`requestPermissionsFromUser failed, code is ${err.code}, message is ${err.message}`);
    })
  }
}

export default PermissionUtil;
