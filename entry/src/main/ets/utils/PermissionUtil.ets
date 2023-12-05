import bundleManager from '@ohos.bundle.bundleManager';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';

const PermissionUtil = {
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

  async checkPermissions(permiss : Array[Permissions]): Promise<void> {
    const permissions: Array<Permissions> = ['ohos.permission.READ_CALENDAR'];
    let grantStatus: abilityAccessCtrl.GrantStatus = await this.checkAccessToken(permissions[0]);

    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      // 已经授权，可以继续访问目标操作
    } else {
      // 申请日历权限
    }
  }
}

export default PermissionUtil;