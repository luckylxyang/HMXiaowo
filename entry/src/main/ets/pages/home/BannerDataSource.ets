import List from '@ohos.util.List'
import ArrayList from '@ohos.util.ArrayList'
import Banner from './Banner'

export default class BannerDataSource implements IDataSource {
  private list: Object[] = []
  private listener: DataChangeListener

  constructor(list: Object[]) {
    this.list = list
  }

  addData(list: Object[]) {
    this.list.push(...list)
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): Object {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener
  }

  unregisterDataChangeListener() {
  }
}